open Core

module Square = struct
  module T = struct
    type t = { file : int; rank : int } [@@deriving sexp, compare, hash]
  end

  include T
  include Comparable.Make (T)
end

module Board = struct
  type t = Piece.t option Square.Map.t [@@deriving sexp]
end

type t = { board : Board.t; turn : Color.t } [@@deriving sexp]

let init () : t =
  In_channel.with_file "data/initial_position.sexp" ~f:(fun ic ->
      Sexplib.Sexp.input_sexp ic |> t_of_sexp)
