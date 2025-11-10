module Vanilla : sig
  type t [@@deriving sexp]
end

module Promotion : sig
  type t [@@deriving sexp]
end

module Castle : sig
  type t = Kingside | Queenside [@@deriving sexp]
end

type t = Vanilla of Vanilla.t | Promotion of Promotion.t | Castle of Castle.t
[@@deriving sexp]
