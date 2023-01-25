extends Node2D

var pressed_tile : Node2D
var hovered_node : Node2D

func _ready():
	for tile in $Tiles.get_children():
		tile.connect("pressed", self, "_on_Tile_pressed", [tile])
		tile.connect("released", self, "_on_Tile_released", [tile])
		

func _physics_process(delta):
	var current_mouse_position = get_global_mouse_position()
	if pressed_tile != null:
		pressed_tile.global_position = current_mouse_position
	var found_hover = false
	for child in $Tiles.get_children():
		if child != pressed_tile and child.contains(current_mouse_position):
			hovered_node = child
			found_hover = true
	if not found_hover:
		hovered_node = null
	
	print(hovered_node)
	
	
#func _on_Area2D_input_event(_viewport, event, _shape_idx):
#	if event is InputEventMouseButton:
#		_held = event.is_pressed()
#
#		if not event.is_pressed():
#			emit_signal("dropped")
#
#
#func _input(event):
#	if _held and event is InputEventMouseMotion:
#		global_position = get_global_mouse_position()	


func _on_Tile_pressed(tile):
		pressed_tile = tile
#		global_position = empty_space.global_position
#		drop_sound.play()

func _on_Tile_released(tile):
		pressed_tile = null
		if hovered_node is Tile:
			$NoDropSound.play()
#		global_position = empty_space.global_position
#		drop_sound.play()
