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

pub fn invert(piece: Piece) -> Piece {
  case piece {
    X -> O
    O -> X
  }
}
