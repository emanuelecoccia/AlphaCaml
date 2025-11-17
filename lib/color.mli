open Core

type t = White | Black [@@deriving sexp, compare]

include Comparable.S with type t := t
