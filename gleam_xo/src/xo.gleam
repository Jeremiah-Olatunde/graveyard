import gleam/io

pub fn main() -> Nil {
  io.println("Hello from xo!")
  let board = Board(X, X, X, X, X, X, X, X, X)

  io.print(to_string_board(board))

  Nil
}

pub type Piece {
  X
  O
  E
}

pub type Board {
  Board(Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece)
}

pub fn to_string_piece(piece: Piece) -> String {
  case piece {
    X -> "x"
    O -> "o"
    E -> " "
  }
}

pub fn to_string_board(board: Board) -> String {
  let Board(a, b, c, d, e, f, g, h, i) = board

  let a = to_string_piece(a)
  let b = to_string_piece(b)
  let c = to_string_piece(c)
  let d = to_string_piece(d)
  let e = to_string_piece(e)
  let f = to_string_piece(f)
  let g = to_string_piece(g)
  let h = to_string_piece(h)
  let i = to_string_piece(i)

  let divider = "-------------\n"
  let row_0 = "| " <> a <> " | " <> b <> " | " <> c <> " |\n"
  let row_1 = "| " <> d <> " | " <> e <> " | " <> f <> " |\n"
  let row_2 = "| " <> g <> " | " <> h <> " | " <> i <> " |\n"

  divider <> row_0 <> divider <> row_1 <> divider <> row_2 <> divider
}

pub fn check_winner(board: Board) -> Piece {
  case board {
    Board(X, X, X, _, _, _, _, _, _) -> X
    Board(_, _, _, X, X, X, _, _, _) -> X
    Board(_, _, _, _, _, _, X, X, X) -> X
    Board(X, _, _, X, _, _, X, _, _) -> X
    Board(_, X, _, _, X, _, _, X, _) -> X
    Board(_, _, X, _, _, X, _, _, X) -> X
    Board(_, _, X, _, X, _, X, _, _) -> X
    Board(X, _, _, _, X, _, _, _, X) -> X
    Board(O, O, O, _, _, _, _, _, _) -> O
    Board(_, _, _, O, O, O, _, _, _) -> O
    Board(_, _, _, _, _, _, O, O, O) -> O
    Board(O, _, _, O, _, _, O, _, _) -> O
    Board(_, O, _, _, O, _, _, O, _) -> O
    Board(_, _, O, _, _, O, _, _, O) -> O
    Board(_, _, O, _, O, _, O, _, _) -> O
    Board(O, _, _, _, O, _, _, _, O) -> O
    Board(_, _, _, _, _, _, _, _, _) -> E
  }
}
