extends Node

onready var _main_theme := find_node("MainTheme")
onready var _end_theme := find_node("EndTheme")


func play_main_theme():
	_main_theme.play()


func play_gameover():
	_main_theme.stop()
	_end_theme.play()


func _increase_volume(audio: AudioStreamPlayer, volume_db ):
	if ( audio.volume_db != volume_db ):
		var decibels = .5
		audio.set_volume_db( audio.volume_db + decibels )


func _process(_delta):
#for every frame ...
	if _end_theme.is_playing():
		_increase_volume( _end_theme , 0 )
