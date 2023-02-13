extends Node2D


func move(new_position: Vector2) -> void:
	global_position = new_position
	visible = true


func hide() -> void:
	visible = false
