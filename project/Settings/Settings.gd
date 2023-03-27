extends Node

func _toggle_fullscreen():
	if Input.is_action_just_pressed("ui_fullscreen_toggle"):
		OS.window_fullscreen = !OS.window_fullscreen

func _process(_delta):
	_toggle_fullscreen()
