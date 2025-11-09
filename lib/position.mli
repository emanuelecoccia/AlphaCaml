type t [@@deriving sexp]

val init : unit -> t
val print_position : t -> unit
