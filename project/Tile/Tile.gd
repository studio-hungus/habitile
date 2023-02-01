class_name Tile
extends Node2D


signal pressed
signal released

export var size := Vector2(175, 175)
var _placed = false


func contains(mouse_position:Vector2) -> bool:
	var center := global_position - size / 2
	var rect = Rect2(center, size)

	return rect.has_point(mouse_position)


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if not _placed:
		if event is InputEventMouseButton:
			if event.is_pressed():
				emit_signal("pressed")
			else:
				emit_signal("released")


func set_placed():
	_placed = true
