import gleam/io

pub fn main() -> Nil {
  io.println("Hello from lang_tour!")

  let increment_by_1 = add4(0, 0, 1, _)
  let increment_by_2 = add4(1, _, 1, 0)
  let increment_by_3 = add4(1, 1, _, 1)

  echo increment_by_1(1)
  echo increment_by_2(1)
  echo increment_by_3(1)

  Nil
}

fn add4(a: Int, b: Int, c: Int, d: Int) -> Int {
  a + b + c + d
}
