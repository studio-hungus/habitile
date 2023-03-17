extends Node

onready var _main_theme := find_node("MainTheme")
onready var _end_theme := find_node("EndTheme")


func play_main_theme():
	_main_theme.play()


func play_gameover_tie():
	$GameOverStinger.stream = load("res://Soundtrack/GL_Stinger_Draw.wav")
	$AnimationPlayer.play("GameOver")


func play_gameover_win():
	$GameOverStinger.stream = load("res://Soundtrack/GL_Sting_Win.wav")
	$AnimationPlayer.play("GameOver")
