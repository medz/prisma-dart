use std::{ffi::CString, collections::HashMap};
use datamodel::diagnostics::Diagnostics;
use query_connector::error::ConnectorError;
use query_core::CoreError;
use libc::c_char;

/// Engine Errors.
#[derive(Debug, thiserror::Error)]
#[repr(C)]
pub enum ApiError {
  #[error("{:?}", _0)]
  Conversion(*mut c_char, *mut c_char),

  #[error("{:?}", _0)]
  Configuration(*mut c_char),

  #[error("{:?}", _0)]
  Core(*mut c_char),

  #[error("{:?}", _0)]
  Connector(*mut c_char),

  #[error("Can't modify an already connected engine.")]
  AlreadyConnected,

  #[error("Engine is not yet connected.")]
  NotConnected,

  #[error("{:?}", _0)]
  JsonDecode(*mut c_char),
}

/// Implementation the `ApiError`.
impl ApiError {
  /// Conversion from `Diagnostics` to `ApiError`.
  pub fn conversion(diagnostics: Diagnostics, dml: impl ToString) -> Self {
    let mut errors = Vec::new();
    for error in diagnostics.errors() {
      errors.push(error.message());

    }

    let mut warnings = Vec::new();
    for warning in diagnostics.warnings() {
      warnings.push(warning.message());
    }

    let mut map = HashMap::new();
    map.insert("errors", errors);
    map.insert("warnings", warnings);

    let json = serde_json::to_string(&map).unwrap();
    let json = CString::new(json).unwrap();
    
    let dml = CString::new(dml.to_string()).unwrap();

    ApiError::Conversion(json.into_raw(), dml.into_raw())
  }

  /// Configuration error.
  pub fn configuration(msg: impl ToString) -> Self {
    let msg = CString::new(msg.to_string()).unwrap();
    Self::Configuration(msg.into_raw())
  }
}

/// Impl for `CoreError`.
impl From<CoreError> for ApiError {
  fn from(err: CoreError) -> Self {
    let msg = CString::new(err.to_string()).unwrap();
    Self::Core(msg.into_raw())
  }
}

/// Impl for `ConnectorError`.
impl From<ConnectorError> for ApiError {
  fn from(err: ConnectorError) -> Self {
    let msg = CString::new(err.to_string()).unwrap();
    Self::Connector(msg.into_raw())
  }
}

/// Impl for url pares error.
impl From<url::ParseError> for ApiError {
  fn from(e: url::ParseError) -> Self {
    Self::configuration(format!("Error parsing connection string: {}", e))
  }
}

/// Impl for connection string error.
impl From<connection_string::Error> for ApiError {
  fn from(e: connection_string::Error) -> Self {
    Self::configuration(format!("Error parsing connection string: {}", e))
  }
}

/// Impl for json error.
impl From<serde_json::Error> for ApiError {
  fn from(e: serde_json::Error) -> Self {
    let e = format!("{}", e);
    let e = CString::new(e).unwrap();
    Self::JsonDecode(e.into_raw())
  }
}