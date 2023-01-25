extends Node2D

var pressed_tile : Node2D
var hovered_node : Node2D
var original_tile_position : Vector2

func _ready():
	for tile in $Tiles.get_children():
		tile.connect("pressed", self, "_on_Tile_pressed", [tile])

func _physics_process(_delta):
	var current_mouse_position = get_global_mouse_position()

	if pressed_tile != null:
		pressed_tile.global_position = current_mouse_position

	var found_hover = false

	# empty_space for loop needs to be first 
	for empty_space in $Board.get_empty_spaces():
		if empty_space.contains(current_mouse_position):
			hovered_node = empty_space
			found_hover = true


	for child in $Tiles.get_children():
		if child != pressed_tile and child.contains(current_mouse_position):
			hovered_node = child
			found_hover = true


	if not found_hover:
		hovered_node = null


func _on_Tile_pressed(tile):
	pressed_tile = tile
	original_tile_position = tile.global_position
	tile.z_index = 10
	tile.connect("released", self, "_on_Tile_released", [tile])


func _on_Tile_released(tile):
	pressed_tile = null
	tile.z_index = 0
	
	if hovered_node is Tile:
		$NoDropSound.play()
		tile.global_position = original_tile_position

	if hovered_node is EmptySpace:
		tile.global_position = hovered_node.global_position
		$DropSound.play()

	tile.disconnect("released", self, "_on_Tile_released")
