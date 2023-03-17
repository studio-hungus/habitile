extends Node

onready var _main_theme := find_node("MainTheme")
onready var _end_theme := find_node("EndTheme")


func play_main_theme():
	_main_theme.play()


func play_gameover():
	$AnimationPlayer.play("GameOver")
