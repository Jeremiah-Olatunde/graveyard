import data_types.{type Person}
import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let person: Person =
    data_types.Athelete(name: "jeremiah olatunde", sport: data_types.Football)
  echo data_types.custom_greeting(person)
  echo person.name
  Nil
}
