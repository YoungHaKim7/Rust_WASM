use std::env;

fn main() {
    println!("Hello Wasm");
    for argument in env::args().skip(1) {
        println!("{}", argument);
    }
}
