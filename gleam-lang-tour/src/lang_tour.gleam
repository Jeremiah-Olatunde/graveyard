import flow_control/case_expressions
import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let sum_to_10: Int =
    case_expressions.list_sum([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

  echo sum_to_10
  Nil
}
