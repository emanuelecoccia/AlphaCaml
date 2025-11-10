module Vanilla = struct
  type t = { piece : Piece.t; from_square : Square.t; to_square : Square.t }
  [@@deriving sexp]
end

module Promotion = struct
  type t = {
    piece : Piece.t;
    from_square : Square.t;
    to_square : Square.t;
    promoted_to : Piece.t;
  }
  [@@deriving sexp]
end

module Castle = struct
  type t = Kingside | Queenside [@@deriving sexp]
end

type t = Vanilla of Vanilla.t | Promotion of Promotion.t | Castle of Castle.t
[@@deriving sexp]
