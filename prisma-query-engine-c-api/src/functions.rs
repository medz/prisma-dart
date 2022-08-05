use std::ffi::CString;
use libc::c_char;

#[repr(C)]
/// The Prisma query engine c api version.
pub struct Version {
  pub commit: *const c_char,
  pub version: *const c_char,
}

/// Get current prisma query engine c api version.
pub extern "C" fn version() -> Version {
  Version {
    commit: CString::new(env!("GIT_HASH")).unwrap().into_raw(),
    version: CString::new(env!("CARGO_PKG_VERSION")).unwrap().into_raw(),
  }
}

#[cfg(test)]
mod tests {
  use std::ffi::CStr;

  // Test version() function
  #[test]
  fn test_version() {
    let version: super::Version = super::version();
    assert_eq!(env!("GIT_HASH"), String::from_utf8_lossy(unsafe { CStr::from_ptr(version.commit) }.to_bytes()));
    assert_eq!(env!("CARGO_PKG_VERSION"), String::from_utf8_lossy(unsafe { CStr::from_ptr(version.version) }.to_bytes()));
  }
}