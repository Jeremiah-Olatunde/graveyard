import prng/random.{type Generator}
import prng/seed.{type Seed}

pub fn main() -> Nil {
  let generator_dice_rolls: Generator(Int) = random.int(1, 6)

  let #(roll_0, next_seed): #(Int, Seed) =
    random.step(generator_dice_rolls, seed.new(0))
  let #(roll_1, next_seed): #(Int, Seed) =
    random.step(generator_dice_rolls, next_seed)
  let #(roll_2, _): #(Int, Seed) = random.step(generator_dice_rolls, next_seed)

  echo roll_0
  echo roll_1
  echo roll_2

  Nil
}
