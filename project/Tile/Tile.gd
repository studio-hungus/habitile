class_name Tile
extends Node2D


signal pressed
signal released

enum State{
	BIG, SMALL
}

export var size := Vector2(175, 175)

onready var _supply_sprite := find_node("SupplyTexture")
onready var _supply_tile := find_node("SupplyTile")
onready var _board_sprite := get_node("BoardSprite")

var _interactable = false
var _pressed = false
var type: TileType
var state = State.BIG setget set_state


func contains(mouse_position: Vector2) -> bool:
	var center := global_position - size / 2
	var rect = Rect2(center, size)
	return rect.has_point(mouse_position)


func _on_Area2D_input_event(_viewport, event: InputEvent, _shape_idx) -> void:
	if _interactable and _is_touched(event) and not _pressed:
			_pressed = true
			emit_signal("pressed")
	elif _interactable and _is_released(event) and _pressed:
		_pressed = false
		emit_signal("released")


func _is_touched(event: InputEvent) -> bool:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == 1:
				return true
	return false


func _is_released(event: InputEvent) -> bool:
	if event is InputEventMouseButton:
		if not event.pressed:
			if event.button_index == 1:
				return true
	return false


func set_interactable(interactable: bool) -> void:
	_interactable = interactable


func initialize_type(init_type: TileType) -> void:
	assert(type == null)

	type = init_type

	_supply_sprite.texture = type.in_supply_texture
	_board_sprite.texture = type.on_board_texture

	find_node("PositivePoints").text = "+%s" % type.positive_score_modifier
	find_node("NegativePoints").text = "-%s" % abs(type.negative_score_modifier)

	find_node("PositiveCreatures").text = ", ".join(type.positive_neighbor_names)
	find_node("NegativeCreatures").text = ", ".join(type.negative_neighbor_names)

	find_node("Name").text = type.name


func get_type() -> TileType:
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


func _enter_small_state() -> void:
	_supply_tile.visible = false
	_board_sprite.visible = true


func calculate_points(neighbors: Array) -> int:
	var points := 0
	var delay_time = 0
	var delay_increment = .30

	for neighbor in neighbors:
		var score_indicator = preload("res://Tile/ScoreIndicator/ScoreIndicator.tscn").instance()
		var _score_modifier := 0

		add_child(score_indicator)
		score_indicator.global_position = neighbor.global_position

		if "Empty Field" in type.positive_neighbor_names and neighbor is EmptySpace:
			_score_modifier = type.positive_score_modifier

		elif "Empty Field" in type.negative_neighbor_names and neighbor is EmptySpace:
			_score_modifier = type.negative_score_modifier

		elif neighbor.type.name in type.positive_neighbor_names:
			_score_modifier = type.positive_score_modifier

		elif neighbor.type.name in type.negative_neighbor_names:
			_score_modifier = type.negative_score_modifier

		points += _score_modifier
		score_indicator.show_score_modified(_score_modifier)
		delay_indicator_animation(score_indicator,delay_time)
		delay_time += delay_increment

	return points


func delay_indicator_animation(score_indicator: Node2D, delay_time: float) -> void:
	var timer = get_tree().create_timer(delay_time)
	timer.connect("timeout", self, "_on_animation_timer_timeout", [score_indicator])


func _on_animation_timer_timeout(score_indicator: Node2D) -> void:
		score_indicator.play_indicate_score()
