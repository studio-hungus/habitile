extends Control


onready var _fullscreen_button := find_node("FullscreenButton")
onready var _mute_button := find_node("MuteButton")
onready var _resign_dialog := find_node("ResignDialogLayer")


func _ready():
	
	if OS.window_fullscreen:
		_fullscreen_button.pressed = true

	if AudioServer.is_bus_mute(0):
		_mute_button.pressed = true




func _on_Play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game/Game.tscn")


func _on_Credits_pressed():
	$CreditScreen.visible = !$CreditScreen.visible


func _on_FullscreenButton_toggled(_button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen


func _on_MuteButton_toggled(button_pressed):
	AudioServer.set_bus_mute(0, button_pressed)
