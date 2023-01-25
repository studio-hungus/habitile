extends Node2D

var empty_space := load("res://Board/EmptySpace/EmptySpace.tscn")

export var width := 6
export var height := 5

var spaces := []


func _ready():
	for x in width:
		for y in height:
			_add_node((width - 1) / 2.0 - x,  (height - 1) / 2.0 - y)


func _add_node(x, y):
	var new_empty_space = empty_space.instance()

	new_empty_space.position.x = x * 175
	new_empty_space.position.y = y * 175

	spaces.append(new_empty_space)
	add_child(new_empty_space)

func get_empty_spaces()-> Array:
	return spaces
