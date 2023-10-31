use psl::diagnostics::Diagnostics;
use query_core::CoreError;
use query_connector::error::ConnectorError;
use thiserror::Error;

#[derive(Debug, Error)]
pub enum ApiError {
    #[error("{:?}", _0)]
    Conversion(Diagnostics, String),

    #[error("{}", _0)]
    Configuration(String),

    #[error("{}", _0)]
    Core(CoreError),

    #[error("{}", _0)]
    Connector(ConnectorError),

    #[error("Can't modify an already connected engine.")]
    AlreadyConnected,

    #[error("Engine is not yet connected.")]
    NotConnected,

    #[error("{}", _0)]
    JsonDecode(String),
}

impl Form<ApiError> for user_facing_errors::Error {
    fn form(err: ApiError) -> Self {
        
    }
}