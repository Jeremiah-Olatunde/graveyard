pub type Piece {
  X
  O
}

pub fn to_string(piece: Piece) -> String {
  case piece {
    X -> "x"
    O -> "o"
  }
}
