import gleam/int
import gleam/list
import gleam/pair
import prng/random.{type Generator}
import prng/seed.{type Seed}

pub fn main() -> Nil {
  let chars: List(String) = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]

  echo list.shuffle(chars)
  echo prng_shuffle(chars, seed.new(0))
  echo prng_shuffle(chars, seed.new(1))

  Nil
}

fn prng_shuffle(ls: List(a), seed: Seed) -> List(a) {
  let generator: Generator(Int) = random.int(random.min_int, random.max_int)

  let #(_, new_list) =
    list.map_fold(ls, seed, fn(seed, item) -> #(Seed, #(Int, a)) {
      let #(int, next_seed) = random.step(generator, seed)
      #(next_seed, #(int, item))
    })

  list.sort(new_list, fn(a, b) { int.compare(a.0, b.0) })
  |> list.map(pair.second)
}
