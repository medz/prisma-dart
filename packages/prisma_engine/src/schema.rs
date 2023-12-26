use std::ffi::{c_char, CStr, CString};

use prisma_fmt as schema;

#[no_mangle]
extern "C" fn schema_format(schema: *const c_char, params: *const c_char) -> *const c_char {
    let schema = unsafe { CStr::from_ptr(schema).to_str().unwrap() };
    let params = unsafe { CStr::from_ptr(params).to_str().unwrap() };
    let formated = schema::format(schema, params);

    CString::new(formated).unwrap().into_raw()
}

#[no_mangle]
extern "C" fn schema_get_configuration(params: *const c_char) -> *const c_char {
    let params = unsafe { CStr::from_ptr(params).to_str().unwrap() };
    let configuration = schema::get_config(params.to_string());
    let configuration = match configuration {
        Ok(configuration) => configuration,
        Err(err) => err,
    };

    CString::new(configuration).unwrap().into_raw()
}

#[no_mangle]
extern "C" fn schema_get_dmmf(params: *const c_char) -> *const c_char {
    let params = unsafe { CStr::from_ptr(params).to_str().unwrap() };
    let dmmf = schema::get_dmmf(params.to_string());
    let dmmf = match dmmf {
        Ok(dmmf) => dmmf,
        Err(err) => err,
    };

    CString::new(dmmf).unwrap().into_raw()
}