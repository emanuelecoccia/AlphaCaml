module Vanilla : sig
  type t [@@deriving sexp]
end

module Promotion : sig
  type t [@@deriving sexp]
end

type t =
  | Vanilla of Vanilla.t
  | Promotion of Promotion.t
  | CastleKingside
  | CastleQueenside
[@@deriving sexp]
