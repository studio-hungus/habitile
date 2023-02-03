extends Node2D


export var _held_tile_z_index := 16
var _original_tile_z_index := 0
var _pressed_tile : Node2D
var _hovered_node : Node2D
var _original_tile_position := Vector2(0, 0)
var _is_left_player_turn := true
var _left_stack = []
var _right_stack = []

onready var _tiles := find_node("Tiles")
onready var _board := find_node("Board")
onready var _no_drop_sound := find_node("NoDropSound")
onready var _drop_sound := find_node("DropSound")
onready var _gui := find_node("GUI")


func _ready() -> void:
	for i in 6:
		_make_new_tile()

	_tiles.get_child(0).global_position = $LeftPlayerPosition1.global_position
	_tiles.get_child(1).global_position = $LeftPlayerPosition2.global_position
	_tiles.get_child(2).global_position = $LeftPlayerPosition3.global_position
	_tiles.get_child(3).global_position = $RightPlayerPosition1.global_position
	_tiles.get_child(4).global_position = $RightPlayerPosition2.global_position
	_tiles.get_child(5).global_position = $RightPlayerPosition3.global_position

	_update_turn_in_gui()


func _physics_process(_delta) -> void:
	var current_mouse_position = get_global_mouse_position()
	var found_hover = false

	if _pressed_tile != null:
		_pressed_tile.global_position = current_mouse_position

	# empty_space for loop needs to be first 
	for empty_space in _board.get_empty_spaces():
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
		_drop_sound.play()
		tile.global_position = _hovered_node.global_position

		_swap_turn()
		tile.set_placed()
		
		_make_new_tile()

	else:
		tile.global_position = _original_tile_position
	
	tile.disconnect("released", self, "_on_Tile_released")


func _update_turn_in_gui() -> void:
	_gui.set_is_left_player_turn(_is_left_player_turn)


func _swap_turn() -> void:
	_is_left_player_turn = !_is_left_player_turn
	_update_turn_in_gui()
	

# This creates a tile in the original tile position
func _make_new_tile() -> void:
	var tile : Node2D = preload("res://Tile/Tile.tscn").instance()
	_tiles.add_child(tile)
	tile.global_position = _original_tile_position
	tile.set_type(tile.TYPE.values()[randi() % tile.TYPE.size()])
	
	# warning-ignore:return_value_discarded
	tile.connect("pressed", self, "_on_Tile_pressed", [tile])
