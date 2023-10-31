use libc::c_char;
use std::ffi::{CStr, CString};

pub fn form(c_str: *const c_char) -> &'static str {
    let c_str = unsafe {
        CStr::from_ptr(c_str)
    };
    
    c_str.to_str().unwrap()
}

pub fn to_str(string: String) -> *const c_char {
    let c_str = CString::new(string).unwrap();
    c_str.into_raw()
}
