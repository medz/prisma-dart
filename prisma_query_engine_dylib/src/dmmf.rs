use std::{ffi::{CString, CStr}, sync::Arc};

use datamodel_connector::ConnectorCapabilities;
use libc::c_char;
use prisma_models::InternalDataModelBuilder;
use query_core::{schema_builder, schema::QuerySchemaRef};
use request_handlers::dmmf;

use crate::{result::Result, error::ApiError};

/// Get DMMF json string from the schema.
#[no_mangle]
pub extern "C" fn dmmf(datamodel_string: *const c_char) -> Result<*const c_char> {
    let datamodel_string = unsafe {
        CStr::from_ptr(datamodel_string).to_str().unwrap()
    };
    let datamodel = datamodel::parse_datamodel(&datamodel_string)
        .map_err(|errors| ApiError::conversion(errors, &datamodel_string)).unwrap();

    let config = datamodel::parse_configuration(&datamodel_string)
        .map_err(|errors| ApiError::conversion(errors, &datamodel_string)).unwrap();
    let datasource = config.subject.datasources.first();

    let capabilities = datasource
        .map(|ds| ds.capabilities())
        .unwrap_or_else(ConnectorCapabilities::empty);

    let referential_integrity = datasource.map(|ds| ds.referential_integrity()).unwrap_or_default();

    let internal_data_model = InternalDataModelBuilder::from(&datamodel.subject).build("".into());

    let query_schema: QuerySchemaRef = Arc::new(schema_builder::build(
        internal_data_model,
        true,
        capabilities,
        config.subject.preview_features().iter().collect(),
        referential_integrity,
    ));

    let dmmf = dmmf::render_dmmf(&datamodel.subject, query_schema);
    let dmmf = serde_json::to_string(&dmmf);
    let dmmf: Result<*const c_char> = match dmmf {
        Ok(dmmf) => {
            let dmmf = CString::new(dmmf).ok().unwrap();
            Result::Ok(dmmf.into_raw())
        },
        Err(e) => {
            let e = ApiError::from(e);
            Result::Err(e)
        },
    };

    dmmf
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_dmmf() {
        let datamodel_string = r#"
generator client {
    provider = "prisma-dart-client"
}

datasource db {
    provider = "postgresql"
    url      = env("DATABASE_URL")
}

model User {
    id          Int @id @default(autoincrement())
    name        String
    createdAt   DateTime @default(now())
}
          "#;
        let dmmf = CString::new(datamodel_string).unwrap();
        let dmmf = dmmf.as_ptr();
        let dmmf = super::dmmf(dmmf);

        match dmmf {
            Result::Ok(dmmf) => {
                let dmmf = unsafe {
                    CStr::from_ptr(dmmf)
                };
                let dmmf = dmmf.to_str().unwrap();
                
                assert!(dmmf.contains("\"name\":\"User\""));
            },
            Result::Err(e) => {
                panic!("{:?}", e);
            }
        };
    }
}