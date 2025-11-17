val get_moves : Position.t -> Move.t list
val is_check : Position.t -> bool
val is_checkmate : Position.t -> bool
val is_stalemate : Position.t -> bool
val is_draw_by_insufficient_material : Position.t -> bool
val is_draw_by_repetition : Position.t list -> bool
val is_draw_by_fifty_move_rule : Move.t list -> bool
