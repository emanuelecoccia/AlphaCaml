open Core

type t [@@deriving sexp, compare]

include Comparable.S with type t := t

val of_tuple : int * int -> t
val to_tuple : t -> int * int
val is_valid : t -> bool
