use std::ffi::CString;

use crate::diagnostics::Diagnostics;
use libc::c_char;
use thiserror::Error;

/// Engine Errors.
#[derive(Debug, Error)]
#[repr(C)]
pub enum ApiError {
  #[error("{:?}", _0)]
  Conversion(Diagnostics, *const c_char),

  #[error("{:?}", _0)]
  Configuration(*const c_char),
}

impl ApiError {
  pub fn conversion(diagnostics: Diagnostics, dml: impl ToString) -> Self {
    let dml = CString::new(dml.to_string()).unwrap();
    Self::Conversion(diagnostics, dml.into_raw())
  }

  pub fn configuration(msg: impl ToString) -> Self {
    let msg = CString::new(msg.to_string()).unwrap();
    Self::Configuration(msg.into_raw())
  }
}