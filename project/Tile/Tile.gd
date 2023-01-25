class_name Tile
extends Node2D

signal pressed
signal released

export var size := Vector2(64, 64)


func contains(mouse_position:Vector2) -> bool:
	var rect = Rect2(global_position - size / 2, size)
	return rect.has_point(mouse_position)


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("pressed")
		else:
			emit_signal("released")
