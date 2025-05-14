pub type Piece {
  X
  O
}

pub fn to_string(player: Piece) -> String {
  case player {
    X -> "x"
    O -> "o"
  }
}
