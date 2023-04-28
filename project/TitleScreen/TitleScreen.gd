extends Control


const FULLSCREEN_PRESSED_ICON := preload("res://SettingsBar/button_fullscreen_shrink_nobg.png")
const FULLSCREEN_UNPRESSED_ICON := preload("res://SettingsBar/button_fullscreen_expand_nobg.png")
const MUTE_PRESSED_ICON := preload("res://SettingsBar/button_sound_off_nobg.png")
const MUTE_UNPRESSED_ICON := preload("res://SettingsBar/button_sound_on_nobg.png")

onready var _game = preload("res://Game/Game.tscn")
onready var _fullscreen_button := find_node("FullscreenButton")
onready var _mute_button := find_node("MuteButton")
onready var _credits_button := find_node("Credits")
onready var _play_button := find_node("Play")
onready var _resign_dialog := find_node("ResignDialogLayer")
onready var _audio_player := find_node("AudioStreamPlayer")
onready var _credits := find_node("CreditScreen")
onready var _button_click := find_node("ButtonClick")


func _ready() -> void:
	#Because the fullscreen button will update upon loading the scene, this code makes sure it is muted
	_button_click.volume_db = -80
	if !_button_click.playing:
		_button_click.play()
	_update_fullscreen_button()
	
	if AudioServer.is_bus_mute(0):
		_mute_button.pressed = true
	_update_mute_button()
	
	yield(_button_click, "finished")
	_button_click.volume_db = 0.75


func _process(_delta):
	# Update fullscreen button icon even if button not pressed
	_update_fullscreen_button()


func _on_Play_pressed() -> void:
	_button_click.play()
	_disable_buttons()
	yield(_button_click, "finished")
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(_game)


func _disable_buttons() -> void:
	_fullscreen_button.disabled = true
	_mute_button.disabled = true
	_credits_button.disabled = true
	_play_button.disabled = true


func _on_Credits_pressed() -> void:
	_button_click.play()
	_credits.visible = !_credits.visible


func _on_FullscreenButton_toggled(button_pressed: bool) -> void:

	if OS.window_fullscreen == button_pressed:
		return

	
	OS.set_window_fullscreen(button_pressed)



func _update_fullscreen_button() -> void:
	_fullscreen_button.pressed = OS.window_fullscreen

	if _fullscreen_button.pressed:
		_fullscreen_button.icon = FULLSCREEN_PRESSED_ICON
	else:
		_fullscreen_button.icon = FULLSCREEN_UNPRESSED_ICON
	

func _on_MuteButton_toggled(button_pressed: bool) -> void:
	_button_click.play()
	AudioServer.set_bus_mute(0, button_pressed)
	_update_mute_button()


func _update_mute_button() -> void:
	if _mute_button.pressed:
		_mute_button.icon = MUTE_PRESSED_ICON
	else:
		_mute_button.icon = MUTE_UNPRESSED_ICON


func _on_PreIntro_play_music() -> void:
	_audio_player.stream_paused = false
