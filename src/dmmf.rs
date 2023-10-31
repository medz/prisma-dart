use libc::c_char;
use prisma_dmmf::dmmf_json_from_schema;

use crate::utils;

#[no_mangle]
pub extern  "C" fn parse(schema: *const c_char) -> *const c_char {
    let schema = utils::str::form(schema);
    let dmmf = dmmf_json_from_schema(schema);

    utils::str::to_str(dmmf)
}