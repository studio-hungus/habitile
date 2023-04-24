extends Node2D


export var _width := 10
export var _height := 4
export(Array, Resource) var _obstacle_types := []
export var _spacing := 180
export(Array, Resource) var _layout := []

var _empty_space_scene := load("res://Board/EmptySpace/EmptySpace.tscn")
var _spaces := []
var _number_of_empty_spaces := 0


func _ready():
	var _layout_index = randi() % 3
	var _obstacle_copy := _obstacle_types.duplicate()
	_obstacle_copy.shuffle()
	for x in _width:
		var x_offset = (_width - 1) / 2.0 - x
		for y in _height:
			var y_offset = (_height - 1) / 2.0 - y
			var node
			# Static obstacle placement, replace with random later
			if Vector2(x,y) in _layout[_layout_index].positions:
				node = _make_new_tile(_obstacle_copy.pop_back())

			else:
				node = _empty_space_scene.instance()
				add_child(node)

				_number_of_empty_spaces += 1
			_add_node(-x_offset,  -y_offset, node)

			


func _add_node(x: float, y: float, node: Node2D) -> void:
	node.position.x = x * _spacing
	node.position.y = y * _spacing

	_spaces.append(node)


func _make_new_tile(tile_type) -> Node2D:
	var tile : Tile = preload("res://Tile/Tile.tscn").instance()

	# Tile need to be added to scene tree before initialization of the type.
	add_child(tile)
	tile.initialize_type(tile_type)

	tile.set_state(1)
	
	return tile


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
func get_neighbors(tile: Node2D) -> Array:
	var index = _spaces.find(tile)
	var y = index % _height
	var x = (index - y) / _height
	var neighbors := []
	var sequence = [1,2,4,7,6,5,3,0]
	for row in 3:
		for column in 3:
			if row == 1 and column == 1:
				continue

			neighbors.append(get_space(x + column - 1, y + row - 1))
	var result := []

	for i in range(neighbors.size()):
		result.append(neighbors[sequence[i]])

	while result.has(null):
		result.erase(null)

	return result


func get_points(tile: Tile, index: int) -> int:
	set_space(tile, index)

	var neighbors := get_neighbors(tile)

	return tile.calculate_points(neighbors)


func set_space(tile: Tile, index: int) -> void:
	_spaces[index] = tile
	_number_of_empty_spaces -= 1


func get_number_of_empty_spaces() -> int:
	return _number_of_empty_spaces
