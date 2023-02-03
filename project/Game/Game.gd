extends Node2D


export var held_tile_z_index := 16
var original_tile_z_index := 0
var pressed_tile : Node2D
var hovered_node : Node2D
var original_tile_position := Vector2(0, 0)
var is_player_one_turn := true
var stack_left := []
var stack_right := []

onready var tiles := find_node("Tiles")
onready var board := find_node("Board")
onready var no_drop_sound := find_node("NoDropSound")
onready var drop_sound := find_node("DropSound")
onready var gui := find_node("GUI")


func _ready():
	randomize()
	for i in 6:
		_make_new_tile()

	tiles.get_child(0).global_position = $LeftPlayerPosition1.global_position
	tiles.get_child(1).global_position = $LeftPlayerPosition2.global_position
	tiles.get_child(2).global_position = $LeftPlayerPosition3.global_position
	tiles.get_child(3).global_position = $RightPlayerPosition1.global_position
	tiles.get_child(4).global_position = $RightPlayerPosition2.global_position
	tiles.get_child(5).global_position = $RightPlayerPosition3.global_position

	_set_turn()


func _physics_process(_delta):
	var current_mouse_position = get_global_mouse_position()
	var found_hover = false

	if pressed_tile != null:
		pressed_tile.global_position = current_mouse_position

	# empty_space for loop needs to be first 
	for empty_space in board.get_empty_spaces():
		if empty_space.contains(current_mouse_position):
			hovered_node = empty_space
			found_hover = true

	for tile in tiles.get_children():
		if tile != pressed_tile and tile.contains(current_mouse_position):
			hovered_node = tile
			found_hover = true
			
	if not found_hover:
		hovered_node = null


func _on_Tile_pressed(tile):
	pressed_tile = tile
	original_tile_position = tile.global_position

	original_tile_z_index = tile.z_index
	tile.z_index = held_tile_z_index

	tile.connect("released", self, "_on_Tile_released", [tile])


func _on_Tile_released(tile):
	pressed_tile = null
	tile.z_index = original_tile_z_index

	if hovered_node is Tile:
		no_drop_sound.play()
		tile.global_position = original_tile_position

	elif hovered_node is EmptySpace:
		drop_sound.play()
		tile.global_position = hovered_node.global_position

		_swap_turn()
		tile.set_placed()
		
		_make_new_tile()

	else:
		tile.global_position = original_tile_position
	
	tile.disconnect("released", self, "_on_Tile_released")


func _set_turn():
	gui.set_turn(is_player_one_turn)


func _swap_turn():
	is_player_one_turn = !is_player_one_turn
	_set_turn()
	

# This creates a tile in the original tile position
func _make_new_tile() -> void:
	var tile = preload("res://Tile/Tile.tscn").instance()
	tiles.add_child(tile)
	tile.global_position = original_tile_position
	tile.set_type(tile.TYPE.values()[randi() % tile.TYPE.size()])
	
	tile.connect("pressed", self, "_on_Tile_pressed", [tile])
