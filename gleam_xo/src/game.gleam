import gleam/option.{type Option, None, Some}

import board.{type Board}
import piece.{type Piece}
import position.{type Position}

pub type Game {
  Aborted
  Settled(board: Board, winner: Option(Piece))
  Ongoing(board: Board, next: Piece)
}

pub fn start() -> Game {
  let board = board.new()
  Ongoing(board: board, next: piece.X)
}

pub fn advance(game: Game, position: Position) -> Result(Game, Nil) {
  case game {
    Aborted -> Error(Nil)
    Settled(_, _) -> Error(Nil)
    Ongoing(board, piece) -> {
      let unoccupied = board.unoccupied(board)

      case unoccupied {
        [] -> Ok(Settled(board, None))
        _ -> {
          let board = board.place(board, piece, position)
          case board {
            Error(_) -> Error(Nil)
            Ok(board) -> {
              let winner = board.winner(board)
              case winner {
                None -> Ok(Ongoing(board, piece.invert(piece)))
                Some(_) -> Ok(Settled(board, winner))
              }
            }
          }
        }
      }
    }
  }
}
