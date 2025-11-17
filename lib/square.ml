open Core

module T = struct
  type t = { file : int; rank : int }
  [@@deriving sexp, compare, fields ~getters]
end

include T
include Comparable.Make (T)

let of_tuple (file, rank) = { file; rank }
let to_tuple { file; rank } = (file, rank)

let is_valid { file; rank } =
  Int.(file >= 0) && Int.(file <= 7) && Int.(rank >= 0) && Int.(rank <= 7)
