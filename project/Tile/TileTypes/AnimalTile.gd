extends Node

onready var supply_sprite = get_node("Sprite")
onready var board_sprite = get_node("SmallSprite")
onready var label = get_node("AnimalName")


func enter_big_state():
	supply_sprite.visible = true
	board_sprite.visible = false
	label.visible = true


func enter_small_state():
	supply_sprite.visible = false
	board_sprite.visible = true
	label.visible = false
