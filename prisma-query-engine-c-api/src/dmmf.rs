use std::{ffi::CString, sync::Arc};

use datamodel::datamodel_connector::ConnectorCapabilities;
use prisma_models::InternalDataModelBuilder;
use query_core::{schema::QuerySchemaRef, schema_builder};
use request_handlers::dmmf;

use crate::json_response::JsonResponse;

pub extern "C" fn dmmf(datamodel_string: *mut CString) -> *mut JsonResponse {
  let datamodel_string = unsafe { datamodel_string.as_ref().unwrap().to_str().unwrap() };
  let datamodel = datamodel::parse_datamodel(datamodel_string).unwrap();
  let config = datamodel::parse_configuration(&datamodel_string).unwrap();
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

  Box::into_raw(Box::new(JsonResponse::ok(dmmf)))
}

#[cfg(test)]
mod tests {
    use std::ffi::CString;

    use crate::json_response::JsonResponse;

  #[test]
  fn test_dmmf() {
    let schema_str = r#"
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
    let datamodel = CString::new(schema_str).unwrap();
    let response = super::dmmf(Box::into_raw(Box::new(datamodel)));
    let response = *unsafe { Box::from_raw(response) };
    let response = match response {
      JsonResponse::Ok(response) => response,
      _ => panic!("Expected Ok"),
    };
    let response = *unsafe { Box::from_raw(response) };
    let response = response.to_str().unwrap();

    println!("{}", response);
  }
}