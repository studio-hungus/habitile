extends CanvasLayer

onready var _button_click := find_node("ButtonClick")


func _on_ExitButton_pressed() -> void:
	_button_click.play()
	visible = !visible

