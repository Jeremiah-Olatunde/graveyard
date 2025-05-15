import gleam/option.{type Option}

import board.{type Board}
import piece.{type Piece}

pub type Game {
  Aborted
  Settled(board: Board, winner: Option(Piece))
  Ongoing(board: Board, next: Piece)
}

pub fn start() -> Game {
  let board = board.new()
  Ongoing(board: board, next: piece.X)
}
