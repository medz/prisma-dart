use query_engine_common::logger::StringCallback;

pub type Function = Box<dyn StringCallback + Sync + Send>;