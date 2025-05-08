import gleam/io
import gleam/list.{Continue, Stop}
import gleam/option.{type Option, None, Some}

pub fn main() -> Nil {
  io.println("Hello from xo!")

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

pub fn print(thing: a, with: fn(a) -> String) {
  thing |> with() |> io.println()
}

pub fn to_string_position(position: BoardPosition) -> String {
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

pub fn to_string_piece(piece: Piece) -> String {
  case piece {
    X -> "x"
    O -> "o"
  }
}

pub fn to_string_move(move: Move) -> String {
  let Move(piece, position) = move
  to_string_piece(piece) <> " plays " <> to_string_position(position)
}

pub fn to_string_board(board: Board) -> String {
  let Board(a, b, c, d, e, f, g, h, i) = board

  let a = a |> option.map(to_string_piece) |> option.unwrap("A")
  let b = b |> option.map(to_string_piece) |> option.unwrap("B")
  let c = c |> option.map(to_string_piece) |> option.unwrap("C")
  let d = d |> option.map(to_string_piece) |> option.unwrap("D")
  let e = e |> option.map(to_string_piece) |> option.unwrap("E")
  let f = f |> option.map(to_string_piece) |> option.unwrap("F")
  let g = g |> option.map(to_string_piece) |> option.unwrap("G")
  let h = h |> option.map(to_string_piece) |> option.unwrap("H")
  let i = i |> option.map(to_string_piece) |> option.unwrap("I")

  let divider = "-------------\n"
  let row_0 = "| " <> a <> " | " <> b <> " | " <> c <> " |\n"
  let row_1 = "| " <> d <> " | " <> e <> " | " <> f <> " |\n"
  let row_2 = "| " <> g <> " | " <> h <> " | " <> i <> " |"

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

pub fn board_place_piece(board: Board, move: Move) -> Result(Board, Nil) {
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

pub fn board_place_piece_unsafe(board: Board, move: Move) -> Board {
  let Move(piece, position) = move

  case position {
    A -> Board(..board, a: Some(piece))
    B -> Board(..board, b: Some(piece))
    C -> Board(..board, c: Some(piece))
    D -> Board(..board, d: Some(piece))
    E -> Board(..board, e: Some(piece))
    F -> Board(..board, f: Some(piece))
    G -> Board(..board, g: Some(piece))
    H -> Board(..board, h: Some(piece))
    I -> Board(..board, i: Some(piece))
  }
}

pub fn board_empty() -> Board {
  Board(None, None, None, None, None, None, None, None, None)
}

pub type Game {
  Game(winner: Option(Piece), board: Board)
}

pub fn game_mock_moves() -> List(Move) {
  let pieces = X |> list.repeat(5) |> list.intersperse(O)
  let positions = [A, B, C, D, E, F, G, H, I] |> list.shuffle
  list.map2(pieces, positions, Move)
}

pub fn game_from_moves_unsafe(moves: List(Move)) -> Game {
  moves
  |> list.fold_until(Game(None, board_empty()), fn(result, move) {
    case result {
      Game(Some(_), _) -> {
        Stop(result)
      }
      Game(None, board) -> {
        let board = board_place_piece_unsafe(board, move)
        let winner = get_winner(board)
        Continue(Game(winner, board))
      }
    }
  })
}
