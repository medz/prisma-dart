use std::os::raw::c_void;

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


// Create a new query engine instance
pub extern "C" fn query_engine_new(
    options: *const c_char,
    callback: Function,
) -> *mut QueryEngine {
    let options = Options(options);
    let options = options.as_constructor_options();

    let engine = QueryEngine::new(options, callback).unwrap();

    Box::into_raw(Box::new(engine))
}

// Free a query engine instance
pub extern "C" fn query_engine_free(engine: *mut QueryEngine) {
    unsafe {
        let _ = Box::from_raw(engine);
    }
}

// Connect to the database
pub extern "C" fn query_engine_connect(engine: *mut QueryEngine, trace: *const c_char, done: extern "C" fn(*const c_void)) {
    let engine = unsafe { &mut *engine };
    let trace = unsafe { std::ffi::CStr::from_ptr(trace) };
    let trace = trace.to_str().unwrap();

    let fut = engine.connect(trace.to_string());
    tokio::spawn(async move {
        let _ = fut.await;
        done(std::ptr::null());
    });
}

// disconnect from the database
pub extern "C" fn query_engine_disconnect(
    engine: *mut QueryEngine, 
    trace: *const c_char,
    done: extern "C" fn(*const c_void)
) {
    let engine = unsafe { &mut *engine };
    let trace = unsafe { std::ffi::CStr::from_ptr(trace) };
    let trace = trace.to_str().unwrap();

    let fut = engine.disconnect(trace.to_string());
    tokio::spawn(async move {
        let _ = fut.await;
        done(std::ptr::null());
    });
}

// Query the database
pub extern "C" fn query_engine_query(
    engine: *mut QueryEngine,
    query: *const c_char,
    trace: *const c_char,
    tx_id: *const c_char,
    done: extern "C" fn(*const c_char),
) {
    let engine = unsafe { &mut *engine };
    let query = unsafe { std::ffi::CStr::from_ptr(query) };
    let query = query.to_str().unwrap();
    let trace = unsafe { std::ffi::CStr::from_ptr(trace) };
    let trace = trace.to_str().unwrap();
    let tx_id = unsafe { std::ffi::CStr::from_ptr(tx_id) };
    let tx_id = tx_id.to_str().unwrap();
    let tx_id = if tx_id.is_empty() { None } else { Some(tx_id.to_string()) };

    let fut = engine.query(query.to_string(), trace.to_string(), tx_id);

    tokio::spawn(async move {
        let result = fut.await;
        let result = serde_json::to_string(&result.unwrap()).unwrap();
        let result = std::ffi::CString::new(result).unwrap();
        let result = result.as_ptr();
        
        done(result);
    });
}

// Start a transaction
pub extern "C" fn query_engine_start_tx(
    engine: *mut QueryEngine,
    trace: *const c_char,
    done: extern "C" fn(*const c_char),
) {
    let engine = unsafe { &mut *engine };
    let trace = unsafe { std::ffi::CStr::from_ptr(trace) };
    let trace = trace.to_str().unwrap();

    let fut = engine.start_transaction(trace.to_string());

    tokio::spawn(async move {
        let result = fut.await;
        let result = serde_json::to_string(&result.unwrap()).unwrap();
        let result = std::ffi::CString::new(result).unwrap();
        let result = result.as_ptr();
        
        done(result);
    });
}

// Commit a transaction
pub extern "C" fn query_engine_commit_tx(
    engine: *mut QueryEngine,
    tx_id: *const c_char,
    done: extern "C" fn(*const c_char),
) {
    let engine = unsafe { &mut *engine };
    let tx_id = unsafe { std::ffi::CStr::from_ptr(tx_id) };
    let tx_id = tx_id.to_str().unwrap();

    let fut = engine.commit_transaction(tx_id.to_string());

    tokio::spawn(async move {
        let result = fut.await;
        let result = serde_json::to_string(&result.unwrap()).unwrap();
        let result = std::ffi::CString::new(result).unwrap();
        let result = result.as_ptr();
        
        done(result);
    });
}

// Rollback a transaction
pub extern "C" fn query_engine_rollback_tx(
    engine: *mut QueryEngine,
    tx_id: *const c_char,
    done: extern "C" fn(*const c_char),
) {
    let engine = unsafe { &mut *engine };
    let tx_id = unsafe { std::ffi::CStr::from_ptr(tx_id) };
    let tx_id = tx_id.to_str().unwrap();

    let fut = engine.rollback_transaction(tx_id.to_string());

    tokio::spawn(async move {
        let result = fut.await;
        let result = serde_json::to_string(&result.unwrap()).unwrap();
        let result = std::ffi::CString::new(result).unwrap();
        let result = result.as_ptr();
        
        done(result);
    });
}
