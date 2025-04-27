import flow_control/case_expressions
import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let list_sum_to_5: Int = case_expressions.list_sum([0, 1, 2, 3, 4, 5])
  let list_sum_to_5_tail_call: Int =
    case_expressions.list_sum_tail_call([0, 1, 2, 3, 4, 5])

  echo list_sum_to_5 == echo list_sum_to_5_tail_call
  Nil
}
