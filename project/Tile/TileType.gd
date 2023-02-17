class_name TileType 
extends Resource

export(String) var name := ""
export(int) var positive_score_modifier := 0
export(int) var negative_score_modifier := 0
export(Array, Resource) var positive_neighbor_tiles := []
export(Texture) var in_supply_texture
export(Texture) var on_board_texture
export(Texture) var icon_texture
