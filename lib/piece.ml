module Kind = struct
  type t = Pawn | Knight | Bishop | Rook | Queen | King [@@deriving sexp]
end

type t = { kind : Kind.t; color : Color.t } [@@deriving sexp, fields ~getters]

let to_ascii = function
  | { kind = Pawn; color = White } -> "♙"
  | { kind = Pawn; color = Black } -> "♟"
  | { kind = Knight; color = White } -> "♘"
  | { kind = Knight; color = Black } -> "♞"
  | { kind = Bishop; color = White } -> "♗"
  | { kind = Bishop; color = Black } -> "♝"
  | { kind = Rook; color = White } -> "♖"
  | { kind = Rook; color = Black } -> "♜"
  | { kind = Queen; color = White } -> "♕"
  | { kind = Queen; color = Black } -> "♛"
  | { kind = King; color = White } -> "♔"
  | { kind = King; color = Black } -> "♚"
