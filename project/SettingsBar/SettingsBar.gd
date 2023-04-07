extends Control

onready var fullscreen_button := find_node("FullscreenButton")
onready var mute_button := find_node("MuteButton")



func _ready():
	if OS.window_fullscreen:
		fullscreen_button.pressed = true

	if AudioServer.is_bus_mute(0):
		mute_button.pressed = true


func _on_FullscreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_MuteButton_toggled(button_pressed):
	AudioServer.set_bus_mute(0, button_pressed)
