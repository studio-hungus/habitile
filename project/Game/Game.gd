extends Node2D


export var _held_tile_z_index := 16
var _original_tile_z_index := 0
var _pressed_tile : Node2D
var _hovered_node : Node2D
var _original_tile_position := Vector2(0, 0)
var _is_left_player_turn := true
var _left_stack := []
var _right_stack := []
var _is_game_over := false

onready var _tiles := find_node("Tiles")
onready var _board := find_node("Board")
onready var _no_drop_sound := find_node("NoDropSound")
onready var _drop_sound := find_node("DropSound")
onready var _gui := find_node("GUI")


func _ready() -> void:
	_create_stacks()
	_shuffle_stacks()
	_display_supply()
	_update_turn_in_gui()


func _physics_process(_delta) -> void:
	if not _is_game_over:
		var current_mouse_position = get_global_mouse_position()
		var found_hover = false

		if _pressed_tile != null:
			_pressed_tile.global_position = current_mouse_position

		# empty_space for loop needs to be first 
		for empty_space in _board.get_spaces():
			if empty_space.contains(current_mouse_position):
				_hovered_node = empty_space
				found_hover = true

		for tile in _tiles.get_children():
			if tile != _pressed_tile and tile.contains(current_mouse_position):
				_hovered_node = tile
				found_hover = true
				
		if not found_hover:
			_hovered_node = null


func _on_Tile_pressed(tile) -> void:
	_pressed_tile = tile
	_original_tile_position = tile.global_position

	_original_tile_z_index = tile.z_index
	tile.z_index = _held_tile_z_index

	tile.connect("released", self, "_on_Tile_released", [tile])


func _on_Tile_released(tile) -> void:
	_pressed_tile = null
	tile.z_index = _original_tile_z_index

	if _hovered_node is Tile:
		_no_drop_sound.play()
		tile.global_position = _original_tile_position

	elif _hovered_node is EmptySpace:
		_place_tile_on_board(tile)

	else:
		tile.global_position = _original_tile_position
	
	tile.disconnect("released", self, "_on_Tile_released")


func _update_turn_in_gui() -> void:
	_gui.set_is_left_player_turn(_is_left_player_turn)


func _swap_turn() -> void:
	_is_left_player_turn = !_is_left_player_turn
	_update_turn_in_gui()
	

# This creates a tile in the original tile position
func _make_new_tile(tile_type) -> Node2D:
	var tile : Node2D = preload("res://Tile/Tile.tscn").instance()
	_tiles.add_child(tile)
	tile.set_type(tile_type)
	
	# warning-ignore:return_value_discarded
	tile.connect("pressed", self, "_on_Tile_pressed", [tile])
	return tile

func _shuffle_stacks():
#	randomize()
	
	_left_stack.shuffle()
	_right_stack.shuffle()


func _create_stacks():
	var quantity_animal_in_stack = 2
	for type in Tile.TYPE.values():
		for animal in quantity_animal_in_stack:
			var left_tile := _make_new_tile(type)
			var right_tile := _make_new_tile(type)
			left_tile.visible = false
			right_tile.visible = false
			_left_stack.append(left_tile)
			_right_stack.append(right_tile)


func _display_supply():
	for i in 3:
		_left_stack[0].visible = true
		_left_stack.pop_front().global_position = $LeftSupply.get_children()[i].global_position
		_right_stack[0].visible = true
		_right_stack.pop_front().global_position = $RightSupply.get_children()[i].global_position
	
	
func _place_tile_on_board(tile : Tile):
	
	_drop_sound.play()
	tile.global_position = _hovered_node.global_position
	
	
	_swap_turn()
	tile.set_placed()
	
	if _is_left_player_turn and _left_stack.size() > 0:
		_left_stack[0].visible = true
		_left_stack.pop_front().global_position = _original_tile_position
	elif not _is_left_player_turn and _right_stack.size() > 0:
		_right_stack[0].visible = true
		_right_stack.pop_front().global_position = _original_tile_position
	
	var index_of_hovered_node = _board.get_spaces().find(_hovered_node)
	_board.set_space(tile, index_of_hovered_node)


func _on_Board_board_filled():
	_is_game_over = true
	_gui.display_gameover()


func _on_GUI_play_again_button_pressed():
	var _current_scene = get_tree().reload_current_scene()
