extends Node

onready var fullscreen_button := find_node("FullscreenButton")
onready var mute_button := find_node("MuteButton")
onready var resign_dialog := find_node("ResignDialogLayer")


var _start_screen := load("res://TitleScreen/TitleScreen.tscn")


func _ready():
	
	fullscreen_button.pressed = OS.window_fullscreen

	if AudioServer.is_bus_mute(0):
		mute_button.pressed = true


func _on_MuteButton_toggled(button_pressed):
	AudioServer.set_bus_mute(0, button_pressed)


func _on_ResignButton_pressed():
	resign_dialog.visible = true


func _on_ConfirmButton_pressed():
	var _current_scene = get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")


func _on_CancelButton_pressed():
	resign_dialog.visible = false


func _on_FullscreenButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
