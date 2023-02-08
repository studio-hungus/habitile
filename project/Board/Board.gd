extends Node2D


signal board_filled


export var width := 6
export var height := 5
export var spacing := 192

var empty_space_scene := load("res://Board/EmptySpace/EmptySpace.tscn")
var spaces := []
var _number_of_empty_spaces : int

func _ready():
	for x in width:
		var x_offset = (width - 1) / 2.0 - x
		for y in height:
			var y_offset = (height - 1) / 2.0 - y
			_add_node(x_offset,  y_offset)
	_number_of_empty_spaces = spaces.size()

func _add_node(x:float, y:float):
	var empty_space = empty_space_scene.instance()

	empty_space.position.x = x * spacing
	empty_space.position.y = y * spacing

	spaces.append(empty_space)
	add_child(empty_space)


func get_spaces() -> Array:
	return spaces


func set_space(tile : Tile, index: int):
	spaces[index] = tile
	_number_of_empty_spaces -= 1
	if _number_of_empty_spaces == 0:
		emit_signal("board_filled")


func get_number_of_empty_spaces() -> int:
	return _number_of_empty_spaces
