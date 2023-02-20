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

var state = State.BIG setget _set_state

onready var _supply_sprite := get_node("SupplySprite")
onready var _board_sprite := get_node("BoardSprite")
onready var _name_label := get_node("AnimalName")
onready var _icons := get_node("Icons")

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


func initialize_type(init_type: TileType):
	assert(type == null)
	
	type = init_type
	
	_supply_sprite.texture = type.in_supply_texture
	_board_sprite.texture = type.on_board_texture
	_name_label.text = type.name
	get_node("AnimalName/Plus").text = "+%s" % type.positive_score_modifier
	get_node("AnimalName/Minus").text = "-%s" % abs(type.negative_score_modifier)
	for i in len(type.postive_icons_textures):
		$Icons/PositiveIcons.get_child(i).texture = type.postive_icons_textures[i]
	for i in len(type.negative_icons_textures):
		$Icons/NegativeIcons.get_child(i).texture = type.negative_icons_textures[i]

func get_type():
	return type


func _set_state(value):
	state = value
	if state == State.BIG:
		_enter_big_state()
	else:
		_enter_small_state()


func _enter_big_state():
	_supply_sprite.visible = true
	_board_sprite.visible = false
	_name_label.visible = true


func _enter_small_state():
	_supply_sprite.visible = false
	_board_sprite.visible = true
	_name_label.visible = false
	_icons.visible = false


func calculate_points(neighbors: Array) -> int:
	var points := 0
	for neighbor in neighbors:
		if type.allergic_to_grass and neighbor is EmptySpace:
			points += type.negative_score_modifier
			continue

		if type.positive_neighbor_tiles.has(neighbor.type):
			points += type.positive_score_modifier
		elif neighbor.type.positive_neighbor_tiles.has(type):
			points += type.negative_score_modifier

	return points
