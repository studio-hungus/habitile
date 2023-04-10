extends Node

onready var fullscreen_button := find_node("FullscreenButton")
onready var mute_button := find_node("MuteButton")
onready var resign_dialog := find_node("ResignDialogLayer")


func _ready():
	if OS.window_fullscreen:
		fullscreen_button.pressed = true

	if AudioServer.is_bus_mute(0):
		mute_button.pressed = true


func _on_FullscreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_MuteButton_toggled(button_pressed):
	AudioServer.set_bus_mute(0, button_pressed)


func _on_ResignButton_pressed():
	resign_dialog.visible = true


func _on_ConfirmButton_pressed():
	var _current_scene = get_tree().reload_current_scene()


func _on_CancelButton_pressed():
	resign_dialog.visible = false
