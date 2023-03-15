class_name EmptySpace
extends Area2D

export var type : Resource
export var _size := Vector2(195, 195)

func contains(mouse_position:Vector2) -> bool:
	var center := global_position - _size / 2
	var rect := Rect2(center, _size)
	
	return rect.has_point(mouse_position)
