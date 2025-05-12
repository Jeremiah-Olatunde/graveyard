import gleam/erlang
import gleam/float
import gleam/int
import gleam/io
import gleam/list.{Continue, Stop}
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

pub fn main() -> Nil {
  io.println("play xo!")

  Nil
}

pub type Move {
  Move(player: Player, position: BoardPosition)
}

pub type Player {
  X
  O
}

pub type Board {
  Board(
    a: Option(Player),
    b: Option(Player),
    c: Option(Player),
    d: Option(Player),
    e: Option(Player),
    f: Option(Player),
    g: Option(Player),
    h: Option(Player),
    i: Option(Player),
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

pub fn position_to_string(position: BoardPosition) -> String {
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

pub type InvalidPosition {
  InvalidPosition(String)
}

pub fn position_from_string(
  position: String,
) -> Result(BoardPosition, InvalidPosition) {
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
    _ -> Error(InvalidPosition(position))
  }
}

pub fn move_read(player: Player) -> Result(Move, InvalidPosition) {
  let assert Ok(position) =
    erlang.get_line("player turn (" <> player_to_string(player) <> "): ")
  position
  |> string.trim()
  |> position_from_string()
  |> result.map(Move(player, _))
}

pub fn repeat_until(fun: fn() -> Result(a, b)) -> a {
  let returned = fun()

  case returned {
    Ok(value) -> value
    Error(_) -> repeat_until(fun)
  }
}

pub fn player_to_string(player: Player) -> String {
  case player {
    X -> "x"
    O -> "o"
  }
}

pub fn move_to_string(move: Move) -> String {
  let Move(player, position) = move
  player_to_string(player) <> " plays " <> position_to_string(position)
}

pub fn board_to_string(board: Board) -> String {
  let Board(a, b, c, d, e, f, g, h, i) = board

  let a = a |> option.map(player_to_string) |> option.unwrap("a")
  let b = b |> option.map(player_to_string) |> option.unwrap("b")
  let c = c |> option.map(player_to_string) |> option.unwrap("c")
  let d = d |> option.map(player_to_string) |> option.unwrap("d")
  let e = e |> option.map(player_to_string) |> option.unwrap("e")
  let f = f |> option.map(player_to_string) |> option.unwrap("f")
  let g = g |> option.map(player_to_string) |> option.unwrap("g")
  let h = h |> option.map(player_to_string) |> option.unwrap("h")
  let i = i |> option.map(player_to_string) |> option.unwrap("i")

  let divider = "-------------\n"
  let divider_no_break = "-------------"
  let row_0 = "| " <> a <> " | " <> b <> " | " <> c <> " |\n"
  let row_1 = "| " <> d <> " | " <> e <> " | " <> f <> " |\n"
  let row_2 = "| " <> g <> " | " <> h <> " | " <> i <> " |\n"

  divider <> row_0 <> divider <> row_1 <> divider <> row_2 <> divider_no_break
}

pub fn get_winner(board: Board) -> Option(Player) {
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

pub fn board_make_move(board: Board, move: Move) -> Result(Board, Nil) {
  let Move(player, position) = move
  let Board(a, b, c, d, e, f, g, h, i) = board

  case position {
    A -> {
      case a {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, a: Some(player)))
      }
    }
    B -> {
      case b {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, b: Some(player)))
      }
    }
    C -> {
      case c {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, c: Some(player)))
      }
    }
    D -> {
      case d {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, d: Some(player)))
      }
    }
    E -> {
      case e {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, e: Some(player)))
      }
    }
    F -> {
      case f {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, f: Some(player)))
      }
    }
    G -> {
      case g {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, g: Some(player)))
      }
    }
    H -> {
      case h {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, h: Some(player)))
      }
    }
    I -> {
      case i {
        Some(_) -> Error(Nil)
        None -> Ok(Board(..board, i: Some(player)))
      }
    }
  }
}

pub fn board_place_player_unsafe(board: Board, move: Move) -> Board {
  let Move(player, position) = move

  case position {
    A -> Board(..board, a: Some(player))
    B -> Board(..board, b: Some(player))
    C -> Board(..board, c: Some(player))
    D -> Board(..board, d: Some(player))
    E -> Board(..board, e: Some(player))
    F -> Board(..board, f: Some(player))
    G -> Board(..board, g: Some(player))
    H -> Board(..board, h: Some(player))
    I -> Board(..board, i: Some(player))
  }
}

pub fn board_empty() -> Board {
  Board(None, None, None, None, None, None, None, None, None)
}

pub fn player_random() -> Player {
  let random = float.random()
  case random <. 0.5 {
    True -> X
    False -> O
  }
}

pub fn board_random() -> Board {
  game_mock_moves(int.random(10))
  |> list.fold(board_empty(), board_place_player_unsafe)
}

pub type Game {
  Game(winner: Option(Player), board: Board)
}

pub type GameX {
  Aborted
  Settled(winner: Player)
  Pending(player: Player, board: Board)
}

pub fn game_mock_moves(count: Int) -> List(Move) {
  let players = X |> list.repeat(5) |> list.intersperse(O)
  let positions =
    [A, B, C, D, E, F, G, H, I] |> list.shuffle |> list.take(count)
  list.map2(players, positions, Move)
}

pub fn game_from_moves_unsafe(moves: List(Move)) -> Game {
  moves
  |> list.fold_until(Game(None, board_empty()), fn(result, move) {
    case result {
      Game(Some(_), _) -> {
        Stop(result)
      }
      Game(None, board) -> {
        let board = board_place_player_unsafe(board, move)
        let winner = get_winner(board)
        Continue(Game(winner, board))
      }
    }
  })
}

pub fn game_empty() -> Game {
  Game(None, board_empty())
}

pub fn game_make_move(game: Game, move: Move) -> Result(Game, Nil) {
  let Game(winner, board) = game

  case winner {
    Some(_) -> Error(Nil)
    None -> {
      let board = board_make_move(board, move)
      result.map(board, fn(board) { Game(get_winner(board), board) })
    }
  }
}

pub fn game_runner() -> Nil {
  let turns = X |> list.repeat(5) |> list.intersperse(O)

  let Game(winner, board) =
    list.fold_until(turns, game_empty(), fn(game, turn) {
      let Game(_, board) = game
      print(board, board_to_string)
      io.println("")

      let assert Ok(move) = move_read(turn)
      let assert Ok(game) = game_make_move(game, move)

      case game {
        Game(Some(_), _) -> Stop(game)
        Game(None, _) -> Continue(game)
      }
    })

  io.println(board_to_string(board))

  case winner {
    Some(player) -> io.println("winner " <> player_to_string(player))
    None -> io.println("draw")
  }
}
