extends Node2D

var _held := false

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		_held = true
		print("Hello or something")
	if event is InputEventMouseButton and not event.is_pressed():
		_held = false
		print("I am unpressed")

func _input(event):
	if _held and event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
	
	
