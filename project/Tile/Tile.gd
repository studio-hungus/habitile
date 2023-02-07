class_name Tile
extends Node2D


signal pressed
signal released

enum TYPE {
	VOLE,SALAMANDER,WORMS,DEER,BEEHIVE,BULLFROG,NORTHERNHARRIER,COYOTE
}


export var size := Vector2(175, 175)
var _interactable = false
var type = TYPE.VOLE


func contains(mouse_position:Vector2) -> bool:
	var center := global_position - size / 2
	var rect = Rect2(center, size)

	return rect.has_point(mouse_position)


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if _interactable:
		if event is InputEventMouseButton:
			if event.is_pressed():
				emit_signal("pressed")
			else:
				emit_signal("released")


func set_interactable(interactable):
	_interactable = interactable


func set_type(new_type):
	type = new_type

	if type == TYPE.SALAMANDER:
		add_child(load("res://Tile/TileTypes/SalamanderTile/SalamanderTile.tscn").instance())
	if type == TYPE.VOLE:
		add_child(load("res://Tile/TileTypes/VoleTile/VoleTile.tscn").instance())
	if type == TYPE.BEEHIVE:
		add_child(load("res://Tile/TileTypes/BeehiveTile/BeehiveTile.tscn").instance())
	if type == TYPE.COYOTE:
		add_child(load("res://Tile/TileTypes/CoyoteTile/CoyoteTile.tscn").instance())
	if type == TYPE.DEER:
		add_child(load("res://Tile/TileTypes/DeerTile/DeerTile.tscn").instance())
	if type == TYPE.WORMS:
		add_child(load("res://Tile/TileTypes/WormsTile/WormsTile.tscn").instance())
	if type == TYPE.BULLFROG:
		add_child(load("res://Tile/TileTypes/BullfrogTile/BullfrogTile.tscn").instance())
	if type == TYPE.NORTHERNHARRIER:
		add_child(load("res://Tile/TileTypes/NortherHarrierTile/NothernHarrierTile.tscn").instance())
