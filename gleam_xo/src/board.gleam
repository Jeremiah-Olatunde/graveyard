import gleam/option.{type Option, None, Some}

import piece.{type Piece}
import position.{type Position, A, B, C, D, E, F, G, H, I}

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

pub fn new() -> Board {
  Board(None, None, None, None, None, None, None, None, None)
}

fn helper(piece: Option(Piece), default: String) {
  piece |> option.map(piece.to_string) |> option.unwrap(default)
}

pub fn to_string(board: Board) -> String {
  let Board(a, b, c, d, e, f, g, h, i) = board

  let a = "a:" <> helper(a, "#")
  let b = "b:" <> helper(b, "#")
  let c = "c:" <> helper(c, "#")
  let d = "d:" <> helper(d, "#")
  let e = "e:" <> helper(e, "#")
  let f = "f:" <> helper(f, "#")
  let g = "g:" <> helper(g, "#")
  let h = "h:" <> helper(h, "#")
  let i = "i:" <> helper(i, "#")

  a <> b <> c <> d <> e <> f <> g <> h <> i
}

pub fn replace(board: Board, piece: Piece, position: Position) -> Board {
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

pub fn place(
  board: Board,
  piece: Piece,
  position: Position,
) -> Result(Board, Nil) {
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
