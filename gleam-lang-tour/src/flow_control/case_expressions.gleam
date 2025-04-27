pub fn factorial(n: Int) -> Int {
  case n {
    0 -> 1
    1 -> 1
    _ -> n * factorial(n - 1)
  }
}

pub fn list_sum(list: List(Int)) -> Int {
  case list {
    [] -> 0
    [first] -> first
    [first, ..rest] -> first + list_sum(rest)
  }
}
