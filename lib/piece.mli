module Kind : sig
  type t = Pawn | Knight | Bishop | Rook | Queen | King [@@deriving sexp]
end

type t = { kind : Kind.t; color : Color.t } [@@deriving sexp, fields ~getters]

val to_ascii : t -> string
