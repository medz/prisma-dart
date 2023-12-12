use engine::{query::QueryEngine, types::Function};
use libc::c_char;

struct Options(*const c_char);

impl Options {
    fn as_str(&self) -> &str {
        let c_str = unsafe { std::ffi::CStr::from_ptr(self.0) };
        c_str.to_str().unwrap()
    }

    fn as_json(&self) -> serde_json::Value {
        serde_json::from_str(self.as_str()).unwrap()
    }

    fn as_constructor_options(&self) -> engine::query::ConstructorOptions {
        serde_json::from_value(self.as_json()).unwrap()
    }
}

type LogCallback = extern "C" fn(*const c_char);

struct Func(LogCallback);

impl engine::logger::StringCallback for Func {
    fn call(&self, message: String) -> Result<(), String> {
        (self.0)(message.as_ptr() as *const c_char);
        Ok(())
    }
}

impl Func {
    fn as_function(&self) -> Function {
        let fun = |message: String| {
            (self.0)(message.as_ptr() as *const c_char);
        };

        Box::new(fun)
    }
}

// Create a new query engine instance
extern "C" fn query_engine_new(
    options: *const c_char,
    callback: extern "C" fn(*const c_char),
) -> *mut QueryEngine {
    let options = Options(options);
    let options = options.as_constructor_options();

    let callback = Func(callback);

    let engine = QueryEngine::new(options, callback).unwrap();

    Box::into_raw(Box::new(engine))
}