class_name Tile
extends Node2D


signal pressed
signal released

enum State{
	BIG, SMALL
}

enum TYPE {
	VOLE,SALAMANDER,WORMS,DEER,BEEHIVE,BULLFROG,NORTHERNHARRIER,COYOTE
}


export var size := Vector2(175, 175)
var _interactable = false
var _pressed = false
var type = TYPE.VOLE
var card_creature

var state = State.BIG setget _set_state


func contains(mouse_position:Vector2) -> bool:
	var center := global_position - size / 2
	var rect = Rect2(center, size)

	return rect.has_point(mouse_position)


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if _interactable:
		if event is InputEventMouseButton:
			if event.is_pressed():
				_pressed = true
				emit_signal("pressed")

			else:
				_pressed = false
				emit_signal("released")


func _process(_delta):
	if not Input.is_mouse_button_pressed(BUTTON_LEFT) and _pressed:
		_pressed = false
		emit_signal("released")


func set_interactable(interactable):
	_interactable = interactable


func set_type(new_type):
	type = new_type

	if type == TYPE.SALAMANDER:
		card_creature = load("res://Tile/TileTypes/SalamanderTile/SalamanderTile.tscn").instance()
	if type == TYPE.VOLE:
		card_creature = load("res://Tile/TileTypes/VoleTile/VoleTile.tscn").instance()
	if type == TYPE.BEEHIVE:
		card_creature = load("res://Tile/TileTypes/BeehiveTile/BeehiveTile.tscn").instance()
	if type == TYPE.COYOTE:
		card_creature = load("res://Tile/TileTypes/CoyoteTile/CoyoteTile.tscn").instance()
	if type == TYPE.DEER:
		card_creature = load("res://Tile/TileTypes/DeerTile/DeerTile.tscn").instance()
	if type == TYPE.WORMS:
		card_creature = load("res://Tile/TileTypes/WormsTile/WormsTile.tscn").instance()
	if type == TYPE.BULLFROG:
		card_creature = load("res://Tile/TileTypes/BullfrogTile/BullfrogTile.tscn").instance()
	if type == TYPE.NORTHERNHARRIER:
		card_creature = load("res://Tile/TileTypes/NortherHarrierTile/NothernHarrierTile.tscn").instance()
	add_child(card_creature)


func get_type():
	return type


func _set_state(value):
	state = value

	if state == State.BIG:
		card_creature.enter_big_state()
	else:
		card_creature.enter_small_state()


func calculate_points(neighbors: Array) -> int:
	var points := 0

	for neighbor in neighbors:
		if (neighbor is EmptySpace):
			if card_creature.positive_neighbor_tiles.has(-1):
				points += card_creature.positive_score_modifier
			elif card_creature.negative_neighbor_tiles.has(-1):
				points += card_creature.negative_score_modifier
		else:
			if card_creature.positive_neighbor_tiles.has(neighbor.type):
				points += card_creature.positive_score_modifier
			elif card_creature.negative_neighbor_tiles.has(neighbor.type):
				points += card_creature.negative_score_modifier

	return points
