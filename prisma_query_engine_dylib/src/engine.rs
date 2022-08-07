use std::{sync::Arc, ffi::CStr, future::Future, panic::AssertUnwindSafe};

use datamodel::{dml::Datamodel, ValidatedConfiguration};
use libc::c_char;
use query_core::schema::QuerySchema;
use tokio::sync::RwLock;
use user_facing_errors::Error;

use crate::{result::Result, error::ApiError};

#[repr(C)]
pub struct QueryEngine {
  inner: RwLock<Inner>
}

enum Inner {
    Builder(EngineBuilder),
    Connected(ConnectedEngine),
}

/// Holding the information to reconnect the engine if needed.
#[derive(Debug, Clone)]
struct EngineDatamodel {
    ast: Datamodel,
    raw: String,
}

/// Everything needed to connect to the database and have the core running.
struct EngineBuilder {
  datamodel: EngineDatamodel,
  config: ValidatedConfiguration,
  // config_dir: PathBuf,
  // env: HashMap<String, String>,
}

/// Internal structure for querying and reconnecting with the engine.
struct ConnectedEngine {
  datamodel: EngineDatamodel,
  query_schema: Arc<QuerySchema>,
  executor: crate::Executor,
  // config_dir: PathBuf,
  // env: HashMap<String, String>,
  // metrics: Option<MetricRegistry>,
}

impl Inner {
  /// Returns a builder if the engine is not connected
  fn as_builder(&self) -> std::result::Result<&EngineBuilder, ApiError> {
      match self {
          Inner::Builder(ref builder) => std::result::Result::Ok(builder),
          Inner::Connected(_) => std::result::Result::Err(ApiError::AlreadyConnected),
      }
  }

  /// Returns the engine if connected
  fn as_engine(&self) -> std::result::Result<&ConnectedEngine, ApiError> {
      match self {
          Inner::Builder(_) => std::result::Result::Err(ApiError::NotConnected),
          Inner::Connected(ref engine) => std::result::Result::Ok(engine),
      }
  }
}

pub extern "C" fn engine_init(datamodel: *const c_char) -> Result<*mut QueryEngine> {
  let datamodel = unsafe {
    CStr::from_ptr(datamodel).to_str().unwrap()
  };
  let config = datamodel::parse_configuration(&datamodel).map_err(|errors| ApiError::conversion(errors, &datamodel)).unwrap();

  config
      .subject
      .validate_that_one_datasource_is_provided()
      .map_err(|errors| ApiError::conversion(errors, &datamodel)).unwrap();

  let ast = datamodel::parse_datamodel(&datamodel)
      .map_err(|errors| ApiError::conversion(errors, &datamodel)).unwrap()
      .subject;

  let datamodel = EngineDatamodel { ast, raw: datamodel.to_string() };

  let builder = EngineBuilder {
    datamodel,
    config,
  };

  Result::Ok(&mut QueryEngine {
    inner: RwLock::new(Inner::Builder(builder)),
  })
}

pub extern "C" fn engine_connect(engine: *mut QueryEngine) -> Result<()> {
  async_panic_to_error(async {
    let engine = unsafe {
      engine.as_mut().unwrap()
    };
    let mut inner = engine.inner.write().await;
    let builder = inner.as_builder().unwrap();

    Result::Ok(())
  });

  Result::Ok(())
}

async fn async_panic_to_error<F, R>(fut: F) -> Result<R>
where
    F: Future<Output = Result<R>>,
{
    let res = fut.await;
    if let Result::Err(err) = res {
      Result::Err(err)
    } else {
        res
    }
}