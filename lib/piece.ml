type t =
  | Pawn of Color.t
  | Knight of Color.t
  | Bishop of Color.t
  | Rook of Color.t
  | Queen of Color.t
  | King of Color.t
[@@deriving sexp]

let to_ascii = function
  | Pawn White -> "♙"
  | Knight White -> "♘"
  | Bishop White -> "♗"
  | Rook White -> "♖"
  | Queen White -> "♕"
  | King White -> "♔"
  | Pawn Black -> "♟"
  | Knight Black -> "♞"
  | Bishop Black -> "♝"
  | Rook Black -> "♜"
  | Queen Black -> "♛"
  | King Black -> "♚"
