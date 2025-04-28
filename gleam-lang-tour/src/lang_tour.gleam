import flow_control/case_expressions
import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let first: Int = case_expressions.third_or_last_element([0])
  let second: Int = case_expressions.third_or_last_element([0, 1])
  let third: Int = case_expressions.third_or_last_element([0, 1, 2])
  let fourth: Int = case_expressions.third_or_last_element([0, 1, 2, 3])
  let fourth_still: Int = case_expressions.third_or_last_element([0, 1, 2, 3])

  echo first
  echo second
  echo third
  echo fourth
  echo fourth_still
  Nil
}
