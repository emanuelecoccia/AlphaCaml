module Board : sig
  type t = Piece.t option Square.Map.t [@@deriving sexp]
end

type t = { board : Board.t; turn : Color.t } [@@deriving sexp]

val init : unit -> t
val print_position : t -> unit
val flip : t -> t
