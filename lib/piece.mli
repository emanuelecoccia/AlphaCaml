module Kind : sig
  type t
end

type t = { kind : Kind.t; color : Color.t } [@@deriving sexp, fields ~getters]

val to_ascii : t -> string
