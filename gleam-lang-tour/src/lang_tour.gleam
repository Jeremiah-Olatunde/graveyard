import flow_control/case_expressions
import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let factorial_10: Int = case_expressions.factorial(10)
  echo factorial_10
  Nil
}
