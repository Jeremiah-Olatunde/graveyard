import flow_control/case_expressions
import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let partition =
    case_expressions.partition_prefixed([
      "keep_turning", "drop_and", "keep_turning", "drop_in", "keep_the",
      "drop_widening", "keep_gyre",
    ])

  echo partition
  Nil
}
