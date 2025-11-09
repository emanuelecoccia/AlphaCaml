open Core

module Board = struct
  type t = Piece.t option Square.Map.t [@@deriving sexp]

  let validate (board : t) =
    Map.iter_keys board ~f:(fun square ->
        if not (Square.is_valid square) then
          raise_s [%message "Square out of bounds: " (square : Square.t)]);

    let expected =
      List.cartesian_product (List.range 0 8) (List.range 0 8)
      |> List.map ~f:(fun (file, rank) -> Square.of_tuple (file, rank))
      |> Square.Set.of_list
    in
    let actual = board |> Map.keys |> Square.Set.of_list in
    if not (Square.Set.equal expected actual) then
      failwith "Board is missing squares or has extra squares";
    board

  let print (t : t) =
    let print_square square =
      match Map.find_exn t square with
      | None -> "."
      | Some piece -> Piece.to_ascii piece
    in
    List.iter (List.range 0 8) ~f:(fun rank ->
        List.iter (List.range 0 8) ~f:(fun file ->
            let square = Square.of_tuple (file, rank) in
            printf "%s " (print_square square));
        printf "\n")

  let t_of_sexp sexp =
    let board = t_of_sexp sexp in
    print board;
    validate board
end

type t = { board : Board.t; turn : Color.t } [@@deriving sexp]

let init () : t =
  In_channel.with_file "positions/init.sexp" ~f:(fun ic ->
      Sexplib.Sexp.input_sexp ic |> t_of_sexp)

let print_position (pos : t) =
  Board.print pos.board;
  printf "%s to move. \n"
    (match pos.turn with White -> "White" | Black -> "Black")
