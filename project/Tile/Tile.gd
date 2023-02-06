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
		$Sprite.modulate = Color.red
	if type == TYPE.BEEHIVE:
		$Sprite.modulate = Color.green
	if type == TYPE.COYOTE:
		$Sprite.modulate = Color.blue
	if type == TYPE.DEER:
		$Sprite.modulate = Color.cyan
	if type == TYPE.WORMS:
		$Sprite.modulate = Color.purple
	if type == TYPE.BULLFROG:
		$Sprite.modulate = Color.brown
	if type == TYPE.NORTHERNHARRIER:
		$Sprite.modulate = Color.black
