class_name TileType 
extends Resource

export(String) var name := ""
export(int) var positive_score_modifier := 0
export(int) var negative_score_modifier := 0
export(Array, Resource) var positive_neighbor_tiles := []
export(bool) var allergic_to_grass := false
export(Texture) var in_supply_texture
export(Texture) var on_board_texture
export(Array, Texture) var postive_icons_textures
export(Array, Texture) var negative_icons_textures
