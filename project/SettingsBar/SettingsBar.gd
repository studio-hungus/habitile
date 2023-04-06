extends Control

onready var fullscreen_button := find_node("FullscreenButton")


func _ready():
	if OS.window_fullscreen:
		fullscreen_button.pressed = true


func _on_FullscreenButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_MuteButton_toggled(button_pressed):
	AudioServer.set_bus_mute(0, button_pressed)
