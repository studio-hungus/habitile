extends CanvasLayer


const FULLSCREEN_PRESSED_ICON := preload("res://SettingsBar/button_fullscreen_shrink_nobg.png")
const FULLSCREEN_UNPRESSED_ICON := preload("res://SettingsBar/button_fullscreen_expand_nobg.png")
const MUTE_PRESSED_ICON := preload("res://SettingsBar/button_sound_off_nobg.png")
const MUTE_UNPRESSED_ICON := preload("res://SettingsBar/button_sound_on_nobg.png")
const RESIGN_PRESSED_ICON := preload("res://SettingsBar/button_flag_press_nobg.png")
const RESIGN_UNPRESSED_ICON := preload("res://SettingsBar/button_flag_nobg.png")

onready var _fullscreen_button := find_node("FullscreenButton")
onready var _mute_button := find_node("MuteButton")
onready var _resign_dialog := find_node("ResignDialogLayer")
onready var _resign_button := find_node("ResignButton")

var _start_screen := load("res://TitleScreen/TitleScreen.tscn")


func _ready() -> void:
	layer = -1
	_update_fullscreen_button()

	if AudioServer.is_bus_mute(0):
		_mute_button.pressed = true
	_update_mute_button()


func _process(_delta):
	_update_fullscreen_button()


func _on_MuteButton_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(0, button_pressed)
	_update_mute_button()


func _update_mute_button() -> void:
	if _mute_button.pressed:
		_mute_button.icon = MUTE_PRESSED_ICON
	else:
		_mute_button.icon = MUTE_UNPRESSED_ICON


func _on_ConfirmButton_pressed() -> void:
	var _current_scene = get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")


func _on_CancelButton_pressed() -> void:
	_resign_dialog.visible = false
	_resign_button.pressed = !_resign_button.pressed
	layer = -1


func _on_FullscreenButton_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed
	_update_fullscreen_button()


func _update_fullscreen_button() -> void:
	_fullscreen_button.pressed = OS.window_fullscreen
	if _fullscreen_button.pressed:
		_fullscreen_button.icon = FULLSCREEN_PRESSED_ICON
	else:
		_fullscreen_button.icon = FULLSCREEN_UNPRESSED_ICON


func _on_ResignButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		layer = 0
		_resign_dialog.visible = true
		_resign_button.icon = RESIGN_PRESSED_ICON
	else:
		layer = -1
		_resign_dialog.visible = false
		_resign_button.icon = RESIGN_UNPRESSED_ICON
