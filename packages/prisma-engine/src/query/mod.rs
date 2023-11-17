mod error;
pub use error::*;

pub(crate) type Result<T> = std::result::Result<T, Error>;