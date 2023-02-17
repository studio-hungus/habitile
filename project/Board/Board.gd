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
			_add_node(-x_offset,  -y_offset)
	_number_of_empty_spaces = spaces.size()


func _add_node(x:float, y:float):
	var empty_space = empty_space_scene.instance()

	empty_space.position.x = x * spacing
	empty_space.position.y = y * spacing

	spaces.append(empty_space)
	add_child(empty_space)


func get_spaces() -> Array:
	return spaces


func get_space(x: int, y: int) -> Node2D:
	if (x < 0) or (y < 0):
		return null
	if (x >= width) or (y >= height):
		return null
	return spaces[x * height + y]


# This solution assumes that the board is being represented as a one dimensional
# in-placement array to work.
func get_neighbors(x: int, y: int) -> Array:
	var neighbors := []

	for i in 3:
		for j in 3:
			if i == 1 and j == 1:
				continue

			neighbors.append(get_space(x + i - 1, y + j - 1))

	while neighbors.has(null):
		neighbors.erase(null)


	return neighbors


func set_space(tile : Tile, index: int) -> int:
	spaces[index] = tile
	_number_of_empty_spaces -= 1
	var y = index % height
	var x = (index - y) / height
	var neighbors := get_neighbors(x, y)
	
	if _number_of_empty_spaces == 0:
		emit_signal("board_filled")
	return tile.calculate_points(neighbors)
	


func get_number_of_empty_spaces() -> int:
	return _number_of_empty_spaces
