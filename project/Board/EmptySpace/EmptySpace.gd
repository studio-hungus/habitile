class_name EmptySpace
extends Area2D

export var size := Vector2(175, 175)


func contains(mouse_position:Vector2) -> bool:
	var rect = Rect2(global_position - size / 2, size)
	return rect.has_point(mouse_position)
