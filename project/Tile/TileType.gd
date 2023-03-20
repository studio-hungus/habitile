class_name TileType 
extends Resource

export(String) var name := ""
export(int) var positive_score_modifier := 0
export(int) var negative_score_modifier := 0
export(Array, String) var positive_neighbor_names := []
export(Array, String) var negative_neighbor_names := []
export(Texture) var in_supply_texture
export(Texture) var on_board_texture

