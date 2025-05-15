import gleam/erlang
import gleam/io
import gleam/option.{None, Some}
import gleam/result
import gleam/string

import board.{type Board, Board}
import game.{type Game}
import piece.{type Piece}
import position.{type Position}

pub fn main() -> Nil {
  io.println("welcome to xo!")
  io.println("")

  let _ = loop(game.start())

  Nil
}

fn loop(game: Game) -> Game {
  repeat(fn() {
    render_game(game)
    case game {
      game.Aborted -> Error(Nil)
      game.Settled(_, _) -> Error(Nil)
      game.Ongoing(_, _) -> {
        let position = repeat(fn() { read_input(game.next) })
        game.advance(game, position)
      }
    }
  })
}

fn render_game(game: Game) -> Nil {
  case game {
    game.Aborted -> io.println("game aborted")
    game.Settled(_, winner) -> {
      case winner {
        None -> io.println("game draw")
        Some(winner) -> io.println("winner: " <> piece.to_string(winner))
      }
    }
    game.Ongoing(board, _) -> render_board(board)
  }
}

fn render_board(board: Board) -> Nil {
  let Board(a, b, c, d, e, f, g, h, i) = board

  let a = a |> option.map(piece.to_string) |> option.unwrap("a")
  let b = b |> option.map(piece.to_string) |> option.unwrap("b")
  let c = c |> option.map(piece.to_string) |> option.unwrap("c")
  let d = d |> option.map(piece.to_string) |> option.unwrap("d")
  let e = e |> option.map(piece.to_string) |> option.unwrap("e")
  let f = f |> option.map(piece.to_string) |> option.unwrap("f")
  let g = g |> option.map(piece.to_string) |> option.unwrap("g")
  let h = h |> option.map(piece.to_string) |> option.unwrap("h")
  let i = i |> option.map(piece.to_string) |> option.unwrap("i")

  let divider = "-------------\n"
  let divider_no_break = "-------------"
  let row_0 = "| " <> a <> " | " <> b <> " | " <> c <> " |\n"
  let row_1 = "| " <> d <> " | " <> e <> " | " <> f <> " |\n"
  let row_2 = "| " <> g <> " | " <> h <> " | " <> i <> " |\n"

  let board =
    divider <> row_0 <> divider <> row_1 <> divider <> row_2 <> divider_no_break

  io.println(board)
}

fn read_input(turn: Piece) -> Result(Position, Nil) {
  let prompt = "player(" <> piece.to_string(turn) <> "):"
  let assert Ok(input) = erlang.get_line(prompt) |> result.map(string.trim)

  let position = position.from_string(input)

  case position {
    Error(_) -> Error(Nil)
    Ok(position) -> Ok(position)
  }
}

fn repeat(f: fn() -> Result(a, b)) -> a {
  let value = f()
  case value {
    Ok(result) -> result
    Error(_) -> repeat(f)
  }
}
