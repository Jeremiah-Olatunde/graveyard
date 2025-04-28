import data_types.{Football}
import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let person = data_types.athelete("jeremiah olatude", Football)
  echo person
  Nil
}
