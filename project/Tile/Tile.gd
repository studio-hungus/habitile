class_name Tile
extends Node2D


signal pressed
signal released


enum State{
	BIG, SMALL
}


export var size := Vector2(175, 175)
var _interactable = false
var _pressed = false
var type: TileType

var state = State.BIG setget set_state

onready var _supply_sprite := find_node("SupplyTexture")
onready var _supply_tile := find_node("SupplyTile")
onready var _board_sprite := get_node("BoardSprite")
onready var _name_label := get_node("AnimalName")


func contains(mouse_position:Vector2) -> bool:
	var center := global_position - size / 2
	var rect = Rect2(center, size)
	return rect.has_point(mouse_position)


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if _interactable and event is InputEventMouseButton:
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


func initialize_type(init_type: TileType):
	assert(type == null)

	type = init_type

	_supply_sprite.texture = type.in_supply_texture
	_board_sprite.texture = type.on_board_texture
	_name_label.text = type.name
	
	find_node("PositivePoints").text = "+%s" % type.positive_score_modifier
	find_node("NegativePoints").text = "-%s" % abs(type.negative_score_modifier)


func get_type():
	return type


func set_state(value) -> void:
	state = value
	if state == State.BIG:
		_enter_big_state()
	else:
		_enter_small_state()


func _enter_big_state() -> void:
	_supply_tile.visible = true
	_board_sprite.visible = false
	_name_label.visible = true


func _enter_small_state() -> void:
	_supply_tile.visible = false
	_board_sprite.visible = true
	_name_label.visible = false


func calculate_points(neighbors: Array) -> int:
	var points := 0
	var delay_time = 0
	var delay_increment = .15

	for neighbor in neighbors:
		var score_indicator = load("res://Tile/ScoreIndicator/ScoreIndicator.tscn").instance()
		var _score_modifier := 0

		add_child(score_indicator)
		score_indicator.global_position = neighbor.global_position

		if type.allergic_to_grass and neighbor is EmptySpace:
			_score_modifier = type.negative_score_modifier

		elif type.positive_neighbor_tiles.has(neighbor.type):
			_score_modifier = type.positive_score_modifier

		elif neighbor.type.positive_neighbor_tiles.has(type):
			_score_modifier = type.negative_score_modifier

		points += _score_modifier
		score_indicator.show_score_modified(_score_modifier, delay_time)
		delay_time += delay_increment

	return points
