use std::env;

use cbindgen;

fn main() {
    let crate_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let builder = cbindgen::Builder::new()
        .with_language(cbindgen::Language::C)
        .with_crate(crate_dir)
        .with_no_includes()
        .with_pragma_once(false)
        .with_std_types(true);

    builder.generate().expect("Unable to generate bindings")
        .write_to_file("include/prisma_engine.h");
}