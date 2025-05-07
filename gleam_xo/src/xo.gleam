import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}

pub fn main() -> Nil {
  io.println("Hello from xo!")

  let moves = generate_game_moves()

  Nil
}

pub type Move {
  Move(piece: Piece, position: BoardPosition)
}

pub type Piece {
  X
  O
}

pub type Board {
  Board(
    a: Option(Piece),
    b: Option(Piece),
    c: Option(Piece),
    d: Option(Piece),
    e: Option(Piece),
    f: Option(Piece),
    g: Option(Piece),
    h: Option(Piece),
    i: Option(Piece),
  )
}

pub type BoardPosition {
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

pub fn place_piece(board: Board, move: Move) -> Result(Board, Nil) {
  let Move(piece, position) = move
  let Board(a, b, c, d, e, f, g, h, i) = board

  case position {
    A -> {
      case a {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, a: Some(piece)))
      }
    }
    B -> {
      case b {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, b: Some(piece)))
      }
    }
    C -> {
      case c {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, c: Some(piece)))
      }
    }
    D -> {
      case d {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, d: Some(piece)))
      }
    }
    E -> {
      case e {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, e: Some(piece)))
      }
    }
    F -> {
      case f {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, f: Some(piece)))
      }
    }
    G -> {
      case g {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, g: Some(piece)))
      }
    }
    H -> {
      case h {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, h: Some(piece)))
      }
    }
    I -> {
      case i {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, i: Some(piece)))
      }
    }
  }
}

pub fn generate_game_moves() -> List(Move) {
  let pieces = X |> list.repeat(5) |> list.intersperse(O)
  let positions = [A, B, C, D, E, F, G, H, I] |> list.shuffle
  list.map2(pieces, positions, Move)
}

pub fn new_board() -> Board {
  Board(None, None, None, None, None, None, None, None, None)
}
