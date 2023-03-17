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

onready var _supply_sprite := get_node("SupplySprite")
onready var _board_sprite := get_node("BoardSprite")
onready var _name_label := get_node("AnimalName")
onready var _icons := get_node("Icons")


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

	get_node("AnimalName/Plus").text = "+%s" % type.positive_score_modifier
	get_node("AnimalName/Minus").text = "-%s" % abs(type.negative_score_modifier)
	for i in len(type.postive_icons_textures):
		var positive_icons = find_node("PositiveIcons")
		positive_icons.get_child(i).texture = type.postive_icons_textures[i]
	for i in len(type.negative_icons_textures):
		var negative_icons = find_node("NegativeIcons")
		negative_icons.get_child(i).texture = type.negative_icons_textures[i]

	#Hides UI elements for tiles that dont have it
	if type.postive_icons_textures.size() == 0:
		find_node("Plus").visible = false
	if type.negative_icons_textures.size() == 0:
		find_node("Minus").visible = false


func get_type():
	return type


func set_state(value) -> void:
	state = value
	if state == State.BIG:
		_enter_big_state()
	else:
		_enter_small_state()


func _enter_big_state() -> void:
	_supply_sprite.visible = true
	_board_sprite.visible = false
	_name_label.visible = true


func _enter_small_state() -> void:
	_supply_sprite.visible = false
	_board_sprite.visible = true
	_name_label.visible = false
	_icons.visible = false


func _show_score_modified(score : int, label : Label, delay : float) -> void:
	var tween = create_tween()
	tween.tween_property(label, "modulate", Color.white , 0.75).set_delay(delay)
	label.text = str(score)
	tween.tween_property(label, "modulate", Color.transparent, 0.5)


func calculate_points(neighbors: Array) -> int:
	var points := 0
	var delay_time = 0
	var delay_increment = .15

	for neighbor in neighbors:
		
		if type.allergic_to_grass and neighbor is EmptySpace:
			points += type.negative_score_modifier
			_show_score_modified(type.negative_score_modifier, neighbor.find_node("ScoreEarned"), delay_time)
			#play bad noise here
			delay_time += delay_increment

		elif type.positive_neighbor_tiles.has(neighbor.type):
			_show_score_modified(type.positive_score_modifier, neighbor.find_node("ScoreEarned"), delay_time)
			points += type.positive_score_modifier
			#play good noise here
			delay_time += delay_increment
		elif neighbor.type.positive_neighbor_tiles.has(type):
			_show_score_modified(type.negative_score_modifier, neighbor.find_node("ScoreEarned"), delay_time)
			points += type.negative_score_modifier
			#play bad noise here
			delay_time += delay_increment
		else:
			_show_score_modified(0, neighbor.find_node("ScoreEarned"), delay_time)
			delay_time += delay_increment
			continue

	return points
