use std::ffi::CString;

#[repr(C)]
pub enum JsonResponse {
    Ok(*mut CString),
    Fail(*mut CString),
}

impl JsonResponse {
    pub fn ok<T: serde::Serialize>(data: T) -> Self {
        let json = serde_json::to_string(&data).unwrap();
        let c_str = Box::into_raw(Box::new(CString::new(json).unwrap()));
        JsonResponse::Ok(c_str)
    }

    pub fn fail<T: serde::Serialize>(data: T) -> Self {
        let json = serde_json::to_string(&data).unwrap();
        let c_str = Box::into_raw(Box::new(CString::new(json).unwrap()));
        JsonResponse::Fail(c_str)
    }
}

