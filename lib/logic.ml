open Core

let is_square_self_blocked (to_square : Square.t) (position : Position.t) =
  let { Position.board; turn } = position in
  match Map.find_exn board to_square with
  | Some { color; _ } -> Color.(turn = color)
  | None -> false

let is_square_free (to_square : Square.t) (position : Position.t) =
  let { Position.board; _ } = position in
  match Map.find_exn board to_square with None -> true | Some _ -> false

let is_capture_available (to_square : Square.t) (position : Position.t) =
  let { Position.board; turn } = position in
  match Map.find_exn board to_square with
  | Some { color; _ } -> Color.(turn <> color)
  | None -> false

let get_moves_pawn (square : Square.t) (prev_move : Move.t)
    (position : Position.t) =
  let rank_ahead =
    match position.turn with
    | White -> square.rank + 1
    | Black -> square.rank - 1
  in
  let diagonal_squares =
    [
      { Square.file = square.file - 1; rank = rank_ahead };
      { Square.file = square.file + 1; rank = rank_ahead };
    ]
    |> List.filter ~f:Square.is_valid
    |> List.filter ~f:(fun square -> is_capture_available square position)
  in
  let square_in_front =
    [ { square with rank = rank_ahead } ]
    |> List.filter ~f:(fun square -> is_square_free square position)
  in
  let to_squares_legal = diagonal_squares @ square_in_front in
  let legal_moves =
    match rank_ahead with
    | 0 | 7 ->
        List.fold
          ([ Knight; Bishop; Rook; Queen ] : Piece.Kind.t list)
          ~init:[]
          ~f:(fun acc kind ->
            List.map to_squares_legal ~f:(fun to_square : Move.t ->
                Promotion
                  {
                    piece = { kind = Pawn; color = position.turn };
                    from_square = square;
                    to_square;
                    promoted_to = { kind; color = position.turn };
                  })
            @ acc)
    | _ ->
        List.map to_squares_legal ~f:(fun to_square : Move.t ->
            Vanilla
              {
                piece = { Piece.kind = Pawn; color = position.turn };
                from_square = square;
                to_square;
              })
  in
  let en_passant =
    match prev_move with
    | Promotion _ | Castle _ -> []
    | Vanilla { piece; from_square; to_square } -> (
        match piece.kind with
        | Knight | Bishop | Rook | Queen | King -> []
        | Pawn -> (
            match abs (from_square.rank - to_square.rank) = 2 with
            | false -> []
            | true -> (
                match abs (square.file - to_square.file) = 1 with
                | false -> []
                | true ->
                    let move : Move.t =
                      Vanilla
                        {
                          piece = { piece with color = position.turn };
                          from_square = square;
                          to_square =
                            {
                              to_square with
                              rank =
                                (match position.turn with
                                | White -> to_square.rank + 1
                                | Black -> to_square.rank - 1);
                            };
                        }
                    in
                    [ move ])))
  in
  let initial_move =
    if Color.(position.turn = White) && square.rank = 1 then
      let square_two_ahead = { Square.file = square.file; rank = 3 } in
      if is_square_free square_two_ahead position then
        [
          Move.Vanilla
            {
              piece = { Piece.kind = Pawn; color = position.turn };
              from_square = square;
              to_square = square_two_ahead;
            };
        ]
      else []
    else if Color.(position.turn = Black) && square.rank = 6 then
      let square_two_ahead = { Square.file = square.file; rank = 4 } in
      if is_square_free square_two_ahead position then
        [
          Move.Vanilla
            {
              piece = { Piece.kind = Pawn; color = position.turn };
              from_square = square;
              to_square = square_two_ahead;
            };
        ]
      else []
    else []
  in
  initial_move @ en_passant @ legal_moves

let get_moves_knight (square : Square.t) (position : Position.t) =
  let to_squares =
    List.fold [ 2; -2 ] ~init:[] ~f:(fun acc offset1 ->
        List.concat
          (List.map [ 1; -1 ] ~f:(fun offset2 ->
               let a =
                 {
                   Square.file = square.file + offset1;
                   rank = square.rank + offset2;
                 }
               in
               let b =
                 {
                   Square.file = square.file + offset2;
                   rank = square.rank + offset1;
                 }
               in
               [ a; b ]))
        @ acc)
  in
  let to_squares_valid =
    List.filter to_squares ~f:(fun to_square -> Square.is_valid to_square)
  in
  let to_squares_legal =
    List.filter to_squares_valid ~f:(fun to_square ->
        not (is_square_self_blocked to_square position))
  in
  List.map to_squares_legal ~f:(fun to_square : Move.t ->
      Vanilla
        {
          piece = { kind = Knight; color = position.turn };
          from_square = square;
          to_square;
        })

let get_moves_bishop square position =
  (* Placeholder implementation for bishop moves *)
  ignore square;
  ignore position;
  []

let get_moves_rook square position =
  (* Placeholder implementation for rook moves *)
  ignore square;
  ignore position;
  []

let get_moves_queen square position =
  (* Placeholder implementation for queen moves *)
  ignore square;
  ignore position;
  []

(* For this we can find all the legal moves by flipping the turn on a position *)
let is_square_attacked square position =
  (* Placeholder implementation for square attack detection *)
  ignore square;
  ignore position;
  false

let get_moves_king square position =
  (* Placeholder implementation for king moves *)
  ignore square;
  ignore position;
  []

let get_moves (position : Position.t) =
  let { Position.board; turn } = position in
  ignore board;
  ignore turn;
  ignore position;
  []

let is_check (position : Position.t) =
  (* Placeholder implementation for check detection *)
  ignore position;
  false

let is_checkmate (position : Position.t) =
  (* Placeholder implementation for checkmate detection *)
  ignore position;
  false

let is_stalemate (position : Position.t) =
  (* Placeholder implementation for stalemate detection *)
  ignore position;
  false

let is_draw_by_insufficient_material (position : Position.t) =
  (* Placeholder implementation for insufficient material detection *)
  ignore position;
  false

let is_draw_by_repetition (positions : Position.t list) =
  (* Placeholder implementation for threefold repetition detection *)
  ignore positions;
  false

let is_draw_by_fifty_move_rule (moves : Move.t list) =
  (* Placeholder implementation for fifty-move rule detection *)
  ignore moves;
  false
;;

ignore get_moves_pawn;
ignore get_moves_knight;
ignore get_moves_bishop;
ignore get_moves_rook;
ignore get_moves_queen;
ignore get_moves_king
