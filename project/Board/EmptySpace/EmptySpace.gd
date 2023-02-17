class_name EmptySpace
extends Area2D

export var type : Resource
export var size := Vector2(175, 175)

func contains(mouse_position:Vector2) -> bool:
	var center := global_position - size / 2
	var rect := Rect2(center, size)
	
	return rect.has_point(mouse_position)
