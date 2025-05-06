import prng/random.{type Generator}
import prng/seed

pub fn main() -> Nil {
  let generator_dice_rolls: Generator(Int) = random.int(1, 6)
  let roll_0: Int = random.sample(generator_dice_rolls, seed.random())
  let roll_1: Int = random.sample(generator_dice_rolls, seed.random())
  let roll_2: Int = random.sample(generator_dice_rolls, seed.random())

  echo roll_0
  echo roll_1
  echo roll_2

  Nil
}
