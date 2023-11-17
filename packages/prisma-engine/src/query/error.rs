pub use psl::diagnostics::Diagnostics;
pub use query_core::CoreError;
pub use query_connector::error::ConnectorError;

/// The file copy of https://github.com/prisma/prisma-engines/blob/main/query-engine/query-engine-wasm/src/error.rs
#[derive(Debug, thiserror::Error)]
pub enum Error {
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

impl From<Error> for user_facing_errors::Error {
    fn from(err: Error) -> Self {
        use std::fmt::Write as _;

        match err {
            Error::Connector(ConnectorError {
                user_facing_error: Some(err),
                ..
            }) => err.into(),
            Error::Conversion(errors, schema) => {
                let mut full_error = errors.to_pretty_string("schema.prisma", &schema);

                write!(full_error, "\nValidation Error Count: {}", errors.errors().len()).unwrap();

                let err = user_facing_errors::common::SchemaParserError {
                    full_error
                };
                let err = user_facing_errors::KnownError::new(err);

                user_facing_errors::Error::from(err)
            },
            Error::Core(error) => user_facing_errors::Error::from(error),
            other => user_facing_errors::Error::new_non_panic_with_current_backtrace(other.to_string()),
        }
    }
}

impl Error {
    pub fn conversion(diagnostics: Diagnostics, dml: impl ToString) -> Self {
        Self::Conversion(diagnostics, dml.to_string())
    }

    pub fn configuration(msg: impl ToString) -> Self {
        Self::Configuration(msg.to_string())
    }
}

impl From<CoreError> for Error {
    fn from(e: CoreError) -> Self {
        match e {
            CoreError::ConfigurationError(message) => Self::Configuration(message),
            core_error => Self::Core(core_error),
        }
    }
}

impl From<ConnectorError> for Error {
    fn from(e: ConnectorError) -> Self {
        Self::Connector(e)
    }
}

impl From<url::ParseError> for Error {
    fn from(e: url::ParseError) -> Self {
        Self::configuration(format!("Error parsing connection string: {e}"))
    }
}

impl From<connection_string::Error> for Error {
    fn from(e: connection_string::Error) -> Self {
        Self::configuration(format!("Error parsing connection string: {e}"))
    }
}

impl From<serde_json::Error> for Error {
    fn from(e: serde_json::Error) -> Self {
        Self::JsonDecode(format!("{e}"))
    }
}


