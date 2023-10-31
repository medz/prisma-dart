mod dmmf;
mod utils;

fn main() {
    let schame = r#"
model User {
    id          Int @id @default(autoincrement())
    name        String
    createdAt   DateTime @default(now())
}
    "#;
    let schame = schame.to_string();
    let schame = utils::str::to_str(schame);
    let dmmf = dmmf::parse(schame);
    let dmmf = utils::str::form(dmmf);

    println!("{}", dmmf);
}
