class_name TileType 
extends Resource

export(int) var positive_score_modifier := 0
export(int) var negative_score_modifier := 0
export(Array, Resource) var positive_neighbor_tiles := []
export(Array, Resource) var negative_neighbor_tiles := []
export(Texture) var in_supply_texture
export(Texture) var on_board_texture
