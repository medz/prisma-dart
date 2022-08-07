pub mod dmmf;
pub mod engine;
pub mod error;
pub mod result;
pub mod version;

pub(crate) type Executor = Box<dyn query_core::QueryExecutor + Send + Sync>;