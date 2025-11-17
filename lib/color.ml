open Core

module T = struct
  type t = White | Black [@@deriving sexp, compare]
end

include T
include Comparable.Make (T)
