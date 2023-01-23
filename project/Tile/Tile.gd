extends Node2D

onready var area := find_node("Area2D")

var _held := false


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		_held = event.is_pressed()
		print("Hello or something")
		if not event.is_pressed():
			_drop()


func _input(event):
	if _held and event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
	
func _drop():
	var emptySpace : Area2D
	var distance := -1.0
	
	if area.get_overlapping_areas().empty():
		return
	
	for overlap in area.get_overlapping_areas():
		if overlap.is_in_group("EmptySpace"):
			var current_distance = overlap.global_position.distance_to(global_position)
			if distance < 0 or distance > current_distance:
				emptySpace = overlap
				distance = current_distance
				emptySpace = overlap
	global_position = emptySpace.global_position
