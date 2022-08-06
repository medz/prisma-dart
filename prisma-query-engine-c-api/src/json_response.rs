use std::ffi::CString;

#[repr(C)]
pub enum JsonResponse {
    Ok(*mut [u8]),
    Fail(*mut [u8]),
}

impl JsonResponse {
    pub fn ok<T: serde::Serialize>(data: T) -> Self {
        let json = serde_json::to_string(&data).unwrap();
        let bytes = CString::new(json).unwrap();
        let bytes = &mut bytes.into_bytes_with_nul();
        let butes = Box::into_raw(Box::new(bytes));
        JsonResponse::Ok(bytes.as_ptr())
        
    }

    pub fn fail<T: serde::Serialize>(data: T) -> Self {
        let json = serde_json::to_string(&data).unwrap();
        let cstring = CString::new(json).unwrap();
        JsonResponse::Fail(cstring.into_raw())
    }
}

