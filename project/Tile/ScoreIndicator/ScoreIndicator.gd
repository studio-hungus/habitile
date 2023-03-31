extends Node2D


onready var _label := find_node("ScoreEarned")
onready var _score_audio := find_node("ScoreAudio")
onready var _timer := find_node("Timer")
onready var _animation_player := find_node("AnimationPlayer")


func show_score_modified(score : int) -> void:

	if score > 0:
		_score_audio.stream = preload("res://Tile/ScoreIndicator/GL_SFX_GoodScore.wav")
	elif score < 0:
		_score_audio.bus = "Lulu (BdScore)"
		_score_audio.stream = preload("res://Tile/ScoreIndicator/GL_SFX_BadScore.wav")
	else:
		_score_audio.stream = preload("res://Tile/ScoreIndicator/GL_SFX_Click.wav")
	_label.text = ("+" if (score >= 0) else "") + str(score)



func play_indicate_score():
	_animation_player.play("IndicateScore")
