use std::ffi::c_char;

pub type Function = extern "C" fn(*const c_char);
