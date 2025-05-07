import gleam/io
import gleam/option.{type Option, None, Some}

pub fn main() -> Nil {
  io.println("Hello from xo!")
  let board =
    Board(
      Some(X),
      Some(X),
      Some(X),
      Some(X),
      Some(X),
      Some(X),
      Some(X),
      Some(X),
      Some(X),
    )

  io.print(to_string_board(board))

  Nil
}

pub type Piece {
  X
  O
}

pub type Board {
  Board(
    Option(Piece),
    Option(Piece),
    Option(Piece),
    Option(Piece),
    Option(Piece),
    Option(Piece),
    Option(Piece),
    Option(Piece),
    Option(Piece),
  )
}

pub fn to_string_piece(piece: Piece) -> String {
  case piece {
    X -> "x"
    O -> "o"
  }
}

pub fn to_string_board(board: Board) -> String {
  let Board(a, b, c, d, e, f, g, h, i) = board

  let a = a |> option.map(to_string_piece) |> option.unwrap(" ")
  let b = b |> option.map(to_string_piece) |> option.unwrap(" ")
  let c = c |> option.map(to_string_piece) |> option.unwrap(" ")
  let d = d |> option.map(to_string_piece) |> option.unwrap(" ")
  let e = e |> option.map(to_string_piece) |> option.unwrap(" ")
  let f = f |> option.map(to_string_piece) |> option.unwrap(" ")
  let g = g |> option.map(to_string_piece) |> option.unwrap(" ")
  let h = h |> option.map(to_string_piece) |> option.unwrap(" ")
  let i = i |> option.map(to_string_piece) |> option.unwrap(" ")

  let divider = "-------------\n"
  let row_0 = "| " <> a <> " | " <> b <> " | " <> c <> " |\n"
  let row_1 = "| " <> d <> " | " <> e <> " | " <> f <> " |\n"
  let row_2 = "| " <> g <> " | " <> h <> " | " <> i <> " |\n"

  divider <> row_0 <> divider <> row_1 <> divider <> row_2 <> divider
}

pub fn get_winner(board: Board) -> Option(Piece) {
  case board {
    Board(Some(X), Some(X), Some(X), _, _, _, _, _, _) -> Some(X)
    Board(_, _, _, Some(X), Some(X), Some(X), _, _, _) -> Some(X)
    Board(_, _, _, _, _, _, Some(X), Some(X), Some(X)) -> Some(X)
    Board(Some(X), _, _, Some(X), _, _, Some(X), _, _) -> Some(X)
    Board(_, Some(X), _, _, Some(X), _, _, Some(X), _) -> Some(X)
    Board(_, _, Some(X), _, _, Some(X), _, _, Some(X)) -> Some(X)
    Board(_, _, Some(X), _, Some(X), _, Some(X), _, _) -> Some(X)
    Board(Some(X), _, _, _, Some(X), _, _, _, Some(X)) -> Some(X)
    Board(Some(O), Some(O), Some(O), _, _, _, _, _, _) -> Some(O)
    Board(_, _, _, Some(O), Some(O), Some(O), _, _, _) -> Some(O)
    Board(_, _, _, _, _, _, Some(O), Some(O), Some(O)) -> Some(O)
    Board(Some(O), _, _, Some(O), _, _, Some(O), _, _) -> Some(O)
    Board(_, Some(O), _, _, Some(O), _, _, Some(O), _) -> Some(O)
    Board(_, _, Some(O), _, _, Some(O), _, _, Some(O)) -> Some(O)
    Board(_, _, Some(O), _, Some(O), _, Some(O), _, _) -> Some(O)
    Board(Some(O), _, _, _, Some(O), _, _, _, Some(O)) -> Some(O)
    Board(_, _, _, _, _, _, _, _, _) -> None
  }
}
