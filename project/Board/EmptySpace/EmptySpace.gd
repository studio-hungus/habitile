class_name EmptySpace
extends Area2D

func contains(mouse_position:Vector2) -> bool:
	var rect = Rect2(global_position - Vector2(32,32), Vector2(64,64))
	return rect.has_point(mouse_position)
