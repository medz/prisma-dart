use std::ffi::{CStr, CString};

/// `c_char` to `String` conversion.
fn c_char_to_string(c_char: *const libc::c_char) -> String {
    unsafe {
        CStr::from_ptr(c_char).to_string_lossy().into_owned()
    }
}

/// `String` to `c_char` conversion.
fn string_to_c_char(string: &str) -> *const libc::c_char {
    CString::new(string).unwrap().into_raw()
}

/// Format a Prisma schema.
#[no_mangle]
pub extern  "C" fn format(schema: *const libc::c_char, params: *const libc::c_char) -> *const libc::c_char {
    let schema: &str = &c_char_to_string(schema);
    let params: &str = &c_char_to_string(params);
    let result: String = prisma_fmt::format(schema, params);
    
    string_to_c_char(&result)
}

/// Lint a Prisma schema.
#[no_mangle]
pub extern  "C" fn lint(schema: *const libc::c_char) -> *const libc::c_char {
    let schema: &str = &c_char_to_string(schema);
    let result: String = prisma_fmt::lint(String::from(schema));

    string_to_c_char(&result)
}
