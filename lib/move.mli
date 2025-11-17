module Vanilla : sig
  type t = { piece : Piece.t; from_square : Square.t; to_square : Square.t }
  [@@deriving sexp]
end

module Promotion : sig
  type t = {
    piece : Piece.t;
    from_square : Square.t;
    to_square : Square.t;
    promoted_to : Piece.t;
  }
  [@@deriving sexp]
end

module Castle : sig
  module Kind : sig
    type t = Kingside | Queenside [@@deriving sexp]
  end

  type t = { kind : Kind.t; color : Color.t } [@@deriving sexp]
end

type t = Vanilla of Vanilla.t | Promotion of Promotion.t | Castle of Castle.t
[@@deriving sexp]
