extends Control

const FULLSCREEN_PRESSED_ICON := preload("res://SettingsBar/button_fullscreen_shrink_nobg.png")
const FULLSCREEN_UNPRESSED_ICON := preload("res://SettingsBar/button_fullscreen_expand_nobg.png")
const MUTE_PRESSED_ICON := preload("res://SettingsBar/button_sound_off_nobg.png")
const MUTE_UNPRESSED_ICON := preload("res://SettingsBar/button_sound_on_nobg.png")

onready var _game = preload("res://Game/Game.tscn")
onready var _fullscreen_button := find_node("FullscreenButton")
onready var _mute_button := find_node("MuteButton")
onready var _resign_dialog := find_node("ResignDialogLayer")
onready var _audio_player := find_node("AudioStreamPlayer")
onready var _credits := find_node("CreditScreen")


func _ready():
	
	_fullscreen_button.pressed = OS.window_fullscreen
	_update_fullscreen_button()
	
	if AudioServer.is_bus_mute(0):
		_mute_button.pressed = true
	_update_mute_button()


func _on_Play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(_game)


func _on_Credits_pressed():
	_credits.visible = !_credits.visible


func _on_FullscreenButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	_update_fullscreen_button()


func _update_fullscreen_button():
	if _fullscreen_button.pressed:
		_fullscreen_button.icon = FULLSCREEN_PRESSED_ICON
	else:
		_fullscreen_button.icon = FULLSCREEN_UNPRESSED_ICON



func _on_MuteButton_toggled(button_pressed):
	AudioServer.set_bus_mute(0, button_pressed)
	_update_mute_button()


func _update_mute_button():
	if _mute_button.pressed:
		_mute_button.icon = MUTE_PRESSED_ICON
	else:
		_mute_button.icon = MUTE_UNPRESSED_ICON



func _on_PreIntro_play_music():
	_audio_player.stream_paused = false
