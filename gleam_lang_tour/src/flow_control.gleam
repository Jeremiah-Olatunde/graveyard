import gleam/dict.{type Dict}
import gleam/list

pub fn factorial(n: Int) -> Int {
  case n {
    0 | 1 -> 1
    _ -> n * factorial(n - 1)
  }
}

pub fn factorial_tail_call(n: Int) -> Int {
  factorial_tail_call_internal(n, 1)
}

fn factorial_tail_call_internal(n: Int, accum: Int) -> Int {
  case n {
    0 | 1 -> 1
    _ -> factorial_tail_call_internal(n - 1, accum * n)
  }
}

pub fn list_sum(list: List(Int)) -> Int {
  case list {
    [] -> 0
    [first] -> first
    [first, ..rest] -> first + list_sum(rest)
  }
}

pub fn list_sum_tail_call(list: List(Int)) -> Int {
  list_sum_tail_call_internal(list, 0)
}

fn list_sum_tail_call_internal(list: List(Int), accum: Int) -> Int {
  case list {
    [] -> 0
    [first] -> first
    [first, ..rest] -> first + list_sum_tail_call_internal(rest, first + accum)
  }
}

pub fn partition_prefixed(strings: List(String)) -> Dict(String, List(String)) {
  list.group(strings, fn(string: String) {
    case string {
      "keep_" <> _ -> "keep"
      "drop_" <> _ -> "drop"
      _ -> panic as "all string must be prefixed with either `drop_` or `keep_`"
    }
  })
}

pub fn third_or_last_element(list: List(a)) -> a {
  case list {
    [] -> panic as "list must have a minimum length of 1"
    [last] | [_, last] | [_, _, last] -> last
    [_, _, _, fourth, ..] -> fourth
  }
}

pub fn get_first_larger(numbers: List(Int), n: Int) -> Result(Int, Nil) {
  case numbers {
    [head, ..] if n < head -> Ok(head)
    [_, ..tail] -> get_first_larger(tail, n)
    [] -> Error(Nil)
  }
}
