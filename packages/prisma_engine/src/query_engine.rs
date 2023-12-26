use std::{ffi::{c_char, CStr}, ptr::null_mut};

use query_engine_common::{engine::{Inner, ConstructorOptions}, error::ApiError};
use tokio::sync::RwLock;

use crate::logger::{Logger, LogCallback};

fn runner<T>(f: impl FnOnce() -> Result<
T, ApiError>) -> T {
    let demo = f().map_err(|err| {
        let err = serde_json::json!({
            "code": match err {
                ApiError::Conversion(_, __) => "Conversion",
                ApiError::Configuration(_) => "Configuration",
                ApiError::Core(_) => "Core",
                ApiError::Connector(_) => "Connector",
                ApiError::AlreadyConnected => "database",
                ApiError::NotConnected => "database",
            },
        });
        err.to_string();
    });
}

pub struct QueryEngine {
    _inner: RwLock<Inner>,
    _logger: Logger,
}

#[repr(C)]
pub struct Context {}

// Context storage for the query engine.
impl Context {
    
}

#[no_mangle]
pub extern "C" fn query_engine_new(options: *const c_char, callback: LogCallback) -> *mut Context {
    let ptr = null_mut();

    ptr.write(options);

    let context = Box::new(Context {});
    
    
    // let options = unsafe {
    //     CStr::from_ptr(options).to_str().unwrap()
    // };
    // let options: ConstructorOptions = serde_json::from_str(options).unwrap();
    // let mut schema = psl::validate(options.datamodel.into());
    // let config = &mut schema.configuration;
    // let preview_features = config.preview_features();


}