use query_engine_wasm::engine::QueryEngine;

type DartString = *const i8;
type VoidCallback = extern "C" fn();
type StringCallback = extern "C" fn(DartString);

type QueryEngineNewCallback = extern "C" fn(*mut QueryEngine);

#[no_mangle]
pub extern "C" fn query_engine_new(
    options: DartString,
    callback: StringCallback,
    created: QueryEngineNewCallback,
    error: VoidCallback,
) {
    let options = unsafe { std::ffi::CStr::from_ptr(options).to_string_lossy().into_owned() };
    let options = serde_json::from_str(&options).unwrap();

    let engine = QueryEngine::new(options, callback);

    match engine {
        Ok(engine) => {
            created(Box::into_raw(Box::new(engine)));
        }
        Err(_) => {
            error();
        }
    }
}

#[no_mangle]
pub extern "C" fn query_engine_connect(engine: *mut QueryEngine, callback: VoidCallback, _error: VoidCallback, trace: DartString) {
    let engine = unsafe { Box::from_raw(engine) };
    let trace = unsafe { std::ffi::CStr::from_ptr(trace).to_string_lossy().into_owned() };

    let rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async move {
        let result = engine.connect(trace).await;

        match result {
            Ok(_) => callback(),
            Err(err) => {
                _error();
                panic!("{:?}", err);
            },
        }
    });
}

#[no_mangle]
pub extern "C" fn query_engine_disconnect(engine: *mut QueryEngine, callback: VoidCallback, _error: VoidCallback, trace: DartString) {
    let engine = unsafe { Box::from_raw(engine) };
    let trace = unsafe { std::ffi::CStr::from_ptr(trace).to_string_lossy().into_owned() };

    let rt = tokio::runtime::Runtime::new().unwrap();
    rt.block_on(async move {
        let result = engine.disconnect(trace).await;

        match result {
            Ok(_) => callback(),
            Err(err) => {
                _error();
                panic!("{:?}", err);
            },
        }
    });
}