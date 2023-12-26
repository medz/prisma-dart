use core::fmt;
use std::{ffi::{c_char, CString, CStr}, collections::BTreeMap};

use query_core::telemetry;
use query_engine_common::{logger::StringCallback, tracer};
use serde_json::Value;
use tracing::{Dispatch, level_filters::LevelFilter, Level, field::{Visit, Field}, Subscriber};
use tracing_subscriber::{filter::{filter_fn, FilterExt}, Layer, Registry, layer::SubscriberExt};

pub(crate) type LogCallback = extern "C" fn(*const c_char) -> *const c_char;

#[derive(Clone)]
pub(crate) struct LogResponder {
    callback: LogCallback,
}

unsafe impl Send for LogResponder {}
unsafe impl Sync for LogResponder {}

pub(crate) struct Logger {
    dispatch: Dispatch,
}

pub(crate) struct LoggerOptions {
    queries: bool,
    level: LevelFilter,
    callback: LogCallback,
    enable_tracing: bool,
}

impl Logger {
    pub fn new(options: LoggerOptions) -> Self {
        let is_sql_query = filter_fn(|meta| {
            meta.target() == "quaint::connector::metrics"
                && meta.fields().iter().any(|f| f.name() == "query")
        });

        let is_mongedb_query = filter_fn(|meta| meta.target() == "mongodb_query_connector::query");

        let filters = if options.queries {
            is_sql_query.or(is_mongedb_query).or(options.level).boxed()
        } else {
            FilterExt::boxed(options.level)
        };

        let callback_layer = CallbackLayer::new(options.callback);

        let telemetry = if options.enable_tracing {
            let is_user_trace = filter_fn(telemetry::helpers::user_facing_span_only_filter);
            let tracer = tracer::new_pipeline().install_simple(Box::new(callback_layer.clone()));

            let telemetry = tracing_opentelemetry::layer()
                .with_tracer(tracer)
                .with_filter(is_user_trace);

            Some(telemetry)
        } else {
            None
        };

        let layer = callback_layer.with_filter(filters);
        let subscriber = Registry::default().with(telemetry).with(layer);

        Self {
            dispatch: Dispatch::new(subscriber),
        }
    }
    
    pub(crate) fn dispatch(&self) -> Dispatch {
        self.dispatch.clone()
    }
}

#[derive(Clone)]
pub(crate) struct CallbackLayer {
    callback: LogCallback,
}

impl CallbackLayer {
    pub(crate) fn new(callback: LogCallback) -> Self {
        Self { callback }
    }
}

impl StringCallback for CallbackLayer {
    fn call(&self, message: String) -> Result<(), String> {
        let message = CString::new(message).unwrap().into_raw();
        let response = (self.callback)(message);

        if response.is_null() {
            Ok(())
        } else {
            let message = unsafe {
                CStr::from_ptr(response).to_str().unwrap()
            };

            Err(message.to_owned())
        }
    }
}

pub struct JsonVisitor<'a> {
    values: BTreeMap<&'a str, Value>,
}

impl<'a> JsonVisitor<'a> {
    pub fn new(level: &Level, target: &str) -> Self {
        let mut values = BTreeMap::new();
        values.insert("level", serde_json::Value::from(level.to_string()));

        // NOTE: previous version used module_path, this is not correct and it should be _target_
        values.insert("module_path", serde_json::Value::from(target));

        JsonVisitor { values }
    }
}

impl<'a> Visit for JsonVisitor<'a> {
    fn record_debug(&mut self, field: &Field, value: &dyn fmt::Debug) {
        match field.name() {
            name if name.starts_with("r#") => {
                self.values
                    .insert(&name[2..], serde_json::Value::from(format!("{value:?}")));
            }
            name => {
                self.values.insert(name, serde_json::Value::from(format!("{value:?}")));
            }
        };
    }

    fn record_i64(&mut self, field: &Field, value: i64) {
        self.values.insert(field.name(), serde_json::Value::from(value));
    }

    fn record_u64(&mut self, field: &Field, value: u64) {
        self.values.insert(field.name(), serde_json::Value::from(value));
    }

    fn record_bool(&mut self, field: &Field, value: bool) {
        self.values.insert(field.name(), serde_json::Value::from(value));
    }

    fn record_str(&mut self, field: &Field, value: &str) {
        self.values.insert(field.name(), serde_json::Value::from(value));
    }
}

impl<'a> ToString for JsonVisitor<'a> {
    fn to_string(&self) -> String {
        serde_json::to_string(&self.values).unwrap()
    }
}

impl<S: Subscriber> Layer<S> for CallbackLayer {
    fn on_event(&self, event: &tracing::Event<'_>, _ctx: tracing_subscriber::layer::Context<'_, S>) {
        let mut visitor = JsonVisitor::new(event.metadata().level(), event.metadata().target());
        event.record(&mut visitor);

        let _ = self.call(visitor.to_string());
    }
}
