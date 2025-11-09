type t =
  | Pawn of Color.t
  | Knight of Color.t
  | Bishop of Color.t
  | Rook of Color.t
  | Queen of Color.t
  | King of Color.t
[@@deriving sexp]

val to_ascii : t -> string
