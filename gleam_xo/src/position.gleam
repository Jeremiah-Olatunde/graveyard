pub type Position {
  A
  B
  C
  D
  E
  F
  G
  H
  I
}

pub fn to_string(position: Position) -> String {
  case position {
    A -> "a"
    B -> "b"
    C -> "c"
    D -> "d"
    E -> "e"
    F -> "f"
    G -> "g"
    H -> "h"
    I -> "i"
  }
}

pub fn from_string(position: String) -> Result(Position, Nil) {
  case position {
    "a" -> Ok(A)
    "b" -> Ok(B)
    "c" -> Ok(C)
    "d" -> Ok(D)
    "e" -> Ok(E)
    "f" -> Ok(F)
    "g" -> Ok(G)
    "h" -> Ok(H)
    "i" -> Ok(I)
    _ -> Error(Nil)
  }
}
