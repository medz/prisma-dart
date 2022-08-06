use crate::error::ApiError;

// pub type Result<T> = std::result::Result<T, ApiError>;
/// Result returned by the engine.
#[derive(Debug)]
#[repr(C)]
pub enum Result<T> {
    /// Success.
    Ok(T),
    /// Error.
    Err(ApiError),
}