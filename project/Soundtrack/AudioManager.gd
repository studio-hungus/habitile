extends Node

onready var _main_theme := find_node("MainTheme")
onready var _game_over_stinger_theme := find_node("GameOverStinger")
onready var _animation_player := find_node("AnimationPlayer")


func play_main_theme():
	_main_theme.play()


func play_gameover_tie():
	_game_over_stinger_theme.stream = load("res://Soundtrack/GL_Stinger_Draw.wav")
	_animation_player.play("GameOver")


func play_gameover_win():
	_game_over_stinger_theme.stream = load("res://Soundtrack/GL_Sting_Win.wav")
	_animation_player.play("GameOver")
