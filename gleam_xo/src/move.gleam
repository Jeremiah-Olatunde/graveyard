import piece.{type Piece}
import position.{type Position}

pub type Move {
  Move(piece: Piece, postion: Position)
}

pub fn to_string(move: Move) -> String {
  let Move(piece, position) = move
  piece.to_string(piece) <> ":" <> position.to_string(position)
}
