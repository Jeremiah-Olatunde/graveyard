import gleam/io

pub fn main() -> Nil {
  io.println("Hello from xo!")
}

pub type Piece {
  X
  O
}

pub type Board {
  Board(Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece)
}
