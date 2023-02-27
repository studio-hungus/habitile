extends Node2D


export var _width := 6
export var _height := 5
export var _spacing := 192

var _empty_space_scene := load("res://Board/EmptySpace/EmptySpace.tscn")
var _spaces := []
var _number_of_empty_spaces : int


func _ready():
	for x in _width:
		var x_offset = (_width - 1) / 2.0 - x
		for y in _height:
			var y_offset = (_height - 1) / 2.0 - y
			_add_node(-x_offset,  -y_offset)
	_number_of_empty_spaces = _spaces.size()


func _add_node(x:float, y:float):
	var _empty_space = _empty_space_scene.instance()

	_empty_space.position.x = x * _spacing
	_empty_space.position.y = y * _spacing

	_spaces.append(_empty_space)
	add_child(_empty_space)


func get_spaces() -> Array:
	return _spaces


func get_space(x: int, y: int) -> Node2D:
	if (x < 0) or (y < 0):
		return null
	if (x >= _width) or (y >= _height):
		return null
	return _spaces[x * _height + y]


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
	_spaces[index] = tile
	_number_of_empty_spaces -= 1
	var y = index % _height
	var x = (index - y) / _height
	var neighbors := get_neighbors(x, y)

	return tile.calculate_points(neighbors)


func get_number_of_empty_spaces() -> int:
	return _number_of_empty_spaces
