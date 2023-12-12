use std::sync::Arc;

use psl::PreviewFeature;
use query_core::{protocol::EngineProtocol, telemetry, schema, TxId, TransactionOptions};
use query_engine_common::{engine::{Inner, stringify_env_values, EngineBuilder, ConnectedEngine, map_known_error}, Result, error::ApiError};
use request_handlers::{load_executor, ConnectorMode, RequestHandler, RequestBody};
use serde_json::json;
use tokio::sync::RwLock;
use tracing::{level_filters::LevelFilter, instrument::WithSubscriber, Instrument, Span, field};

use crate::{logger::Logger, types::Function};

pub use query_engine_common::engine::ConstructorOptions;

pub struct QueryEngine {
    inner: RwLock<Inner>,
    logger: Logger,
}

impl QueryEngine {
    pub fn new(
        options: ConstructorOptions,
        callback: Function,
    ) -> Result<Self> {
        let log_callback = callback;
        let env = stringify_env_values(options.env)?;
        let overrides: Vec<(_, _)> = options.datasource_overrides.into_iter().collect();

        let mut schema = psl::validate(options.datamodel.into());
        let config = &mut schema.configuration;
        let preview_features = config.preview_features();

        schema
            .diagnostics
            .to_result()
            .map_err(|err| ApiError::conversion(err, schema.db.source()))?;

        config
            .resolve_datasource_urls_query_engine(
                &overrides,
                |key| env.get(key).map(ToString::to_string),
                options.ignore_env_var_errors,
            )
            .map_err(|err| ApiError::conversion(err, schema.db.source()))?;

        config
            .validate_that_one_datasource_is_provided()
            .map_err(|err| ApiError::conversion(err, schema.db.source()))?;

        let enable_tracing = preview_features.contains(PreviewFeature::Tracing);
        let engine_protocol = options.engine_protocol.unwrap_or(EngineProtocol::Json);

        let builder = EngineBuilder {
            schema: Arc::new(schema),
            config_dir: options.config_dir,
            engine_protocol,
            env,
        };

        let log_level = options.log_level.parse::<LevelFilter>().unwrap();
        let logger = Logger::new(options.log_queries, log_level, log_callback, enable_tracing);

        Ok(Self {
            inner: RwLock::new(Inner::Builder(builder)),
            logger,
        })
    }

    /// Connect to the database, allow queries to be run.
    pub async fn connect(&self, trace: String) -> Result<()> {
        let dispatcher = self.logger.dispatcher();

        async {
            let span = tracing::info_span!("prisma:engine:connect");
            telemetry::helpers::set_parent_context_from_json_str(&span, &trace);

            let mut inner = self.inner.write().await;
            let builder = inner.as_builder()?;
            let arced_schema = Arc::clone(&builder.schema);
            let arced_schema_2 = Arc::clone(&builder.schema);

            let url = {
                let data_source = builder
                    .schema
                    .configuration
                    .datasources
                    .first()
                    .ok_or_else(|| ApiError::configuration("No valid data source found"))?;
                data_source
                    .load_url_with_config_dir(&builder.config_dir, |key| builder.env.get(key).map(ToString::to_string))
                    .map_err(|err| ApiError::Conversion(err, builder.schema.db.source().to_owned()))?
            };

            let engine = async move {
                // We only support one data source & generator at the moment, so take the first one (default not exposed yet).
                let data_source = arced_schema
                    .configuration
                    .datasources
                    .first()
                    .ok_or_else(|| ApiError::configuration("No valid data source found"))?;

                let preview_features = arced_schema.configuration.preview_features();

                let executor = load_executor(ConnectorMode::Rust, data_source, preview_features, &url).await?;
                let connector = executor.primary_connector();

                let conn_span = tracing::info_span!(
                    "prisma:engine:connection",
                    user_facing = true,
                    "db.type" = connector.name(),
                );

                connector.get_connection().instrument(conn_span).await?;

                let query_schema_span = tracing::info_span!("prisma:engine:schema");
                let query_schema = query_schema_span.in_scope(|| schema::build(arced_schema_2, true));

                Ok(ConnectedEngine {
                    schema: builder.schema.clone(),
                    query_schema: Arc::new(query_schema),
                    executor,
                    config_dir: builder.config_dir.clone(),
                    env: builder.env.clone(),
                    engine_protocol: builder.engine_protocol,
                    metrics: None,
                }) as Result<ConnectedEngine>
            }
            .instrument(span)
            .await?;

            *inner = Inner::Connected(engine);

            Ok(())
        }
        .with_subscriber(dispatcher)
        .await
    }

    pub async fn disconnect(&self, trace: String) -> Result<()> {
        let dispatcher = self.logger.dispatcher();

        async {
            let span = tracing::info_span!("prisma:engine:disconnect");
            let _ = telemetry::helpers::set_parent_context_from_json_str(&span, &trace);

            async {
                let mut inner = self.inner.write().await;
                let engine = inner.as_engine()?;

                let builder = EngineBuilder {
                    schema: engine.schema.clone(),
                    config_dir: engine.config_dir.clone(),
                    env: engine.env.clone(),
                    engine_protocol: engine.engine_protocol(),
                };

                *inner = Inner::Builder(builder);

                Ok(())
            }
            .instrument(span)
            .await
        }
        .with_subscriber(dispatcher)
        .await
    }

    pub async fn query(
        &self,
        body: String,
        trace: String,
        tx_id: Option<String>,
    ) -> Result<String> {
        let dispatcher = self.logger.dispatcher();

        async {
            let inner = self.inner.read().await;
            let engine = inner.as_engine()?;

            let query = RequestBody::try_from_str(&body, engine.engine_protocol())?;

            async move {
                let span = if tx_id.is_none() {
                    tracing::info_span!("prisma:engine", user_facing = true)
                } else {
                    Span::none()
                };

                let trace_id = telemetry::helpers::set_parent_context_from_json_str(&span, &trace);

                let handler = RequestHandler::new(engine.executor(), engine.query_schema(), engine.engine_protocol());
                let response = handler
                    .handle(query, tx_id.map(TxId::from), trace_id)
                    .instrument(span)
                    .await;

                Ok(serde_json::to_string(&response)?)
            }
            .await
        }
        .with_subscriber(dispatcher)
        .await
    }

    pub async fn start_transaction(&self, input: String) -> Result<String> {
        let inner = self.inner.read().await;
        let engine = inner.as_engine()?;
        let dispatcher = self.logger.dispatcher();

        async move {
            let span = tracing::info_span!("prisma:engine:itx_runner", user_facing = true, itx_id = field::Empty);

            let tx_opts: TransactionOptions = serde_json::from_str(&input)?;
            match engine
                .executor()
                .start_tx(engine.query_schema().clone(), engine.engine_protocol(), tx_opts)
                .instrument(span)
                .await
            {
                Ok(tx_id) => Ok(json!({ "id": tx_id.to_string() }).to_string()),
                Err(err) => Ok(map_known_error(err)?),
            }
        }
        .with_subscriber(dispatcher)
        .await
    }

    pub async fn commit_transaction(&self, tx_id: String) -> Result<String> {
        let inner = self.inner.read().await;
        let engine = inner.as_engine()?;

        let dispatcher = self.logger.dispatcher();

        async move {
            match engine.executor().commit_tx(TxId::from(tx_id)).await {
                Ok(_) => Ok("{}".to_string()),
                Err(err) => Ok(map_known_error(err)?),
            }
        }
        .with_subscriber(dispatcher)
        .await
    }

    pub async fn rollback_transaction(&self, tx_id: String) -> Result<String> {
        let inner = self.inner.read().await;
        let engine = inner.as_engine()?;

        let dispatcher = self.logger.dispatcher();

        async move {
            match engine.executor().rollback_tx(TxId::from(tx_id)).await {
                Ok(_) => Ok("{}".to_string()),
                Err(err) => Ok(map_known_error(err)?),
            }
        }
        .with_subscriber(dispatcher)
        .await
    }
}