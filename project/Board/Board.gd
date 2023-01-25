extends Node2D


export var width := 6
export var height := 5
var empty_space_scene := load("res://Board/EmptySpace/EmptySpace.tscn")
var spaces := []


func _ready():
	for x in width:
		var x_offset = (width - 1) / 2.0 - x
		for y in height:
			var y_offset = (height - 1) / 2.0 - y
			_add_node(x_offset,  y_offset)


func _add_node(x:float, y:float):
	var empty_space = empty_space_scene.instance()

	empty_space.position.x = x * empty_space.size.x
	empty_space.position.y = y * empty_space.size.y

	spaces.append(empty_space)
	add_child(empty_space)


func get_empty_spaces() -> Array:
	return spaces
