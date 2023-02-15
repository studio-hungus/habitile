## This is the node that glows that indicate the tile can be dropped here.
extends Node2D

func move(new_position: Vector2) -> void:
	global_position = new_position
	visible = true


func hide() -> void:
	visible = false
