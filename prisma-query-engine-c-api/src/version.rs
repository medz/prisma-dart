use crate::json_response::JsonResponse;
use serde::ser::{Serialize, SerializeStruct, Serializer};

struct Version {
  pub commit: &'static str,
  pub version: &'static str,
}

impl Serialize for Version {
  fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
  where S: Serializer,
  {
    let mut s = serializer.serialize_struct("Version", 2)?;
    s.serialize_field("commit", &self.commit)?;
    s.serialize_field("version", &self.version)?;
    s.end()
  }
}

/// Get the version of the library.
#[no_mangle]
pub extern "C" fn version() -> *mut JsonResponse {
  let version = Version {
    commit: env!("GIT_HASH"),
    version: env!("CARGO_PKG_VERSION"),
  };
  Box::into_raw(Box::new(JsonResponse::ok(version)))
}

#[cfg(test)]
mod tests {
  use crate::json_response::JsonResponse;

  #[test]
  fn test_version() {
    let version = super::version();
    let version = *unsafe { Box::from_raw(version) };
    let version = match version {
      JsonResponse::Ok(version) => version,
      _ => panic!("Expected Ok"),
    };
    // let version = *unsafe { Box::from_raw(version) };
    // let version = version.to_str().unwrap();

    println!("{:?}", version);
  }
}
