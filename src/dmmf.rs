use libc::c_char;
use prisma_request_handlers::dmmf;

use crate::utils;

#[no_mangle]
pub extern  "C" fn parse(schema: *const c_char) -> *const c_char {
    let schema = utils::str::form(schema);
    let schema = prisma_psl::validate(schema.into());

    schema.db;
}