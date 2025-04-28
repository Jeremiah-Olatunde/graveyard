import data_types.{Football}
import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let person = data_types.athelete("jeremiah olatude", 23, Football)
  echo person
  Nil
}
