extends Node2D

var pressed_tile : Node2D

func _ready():
	for tile in $Tiles.get_children():
		tile.connect("pressed", self, "_on_Tile_pressed", [tile])
		tile.connect("released", self, "_on_Tile_released", [tile])
		

func _physics_process(delta):
	var current_mouse_position = get_global_mouse_position()
	if pressed_tile != null:
		pressed_tile.global_position = current_mouse_position
	for child in $Tiles.get_children():
		if child.contains(current_mouse_position):
			print("heck")
			return
	print("nothing")
	
	
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
#		global_position = empty_space.global_position
#		drop_sound.play()
