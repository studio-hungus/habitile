extends Node2D


onready var label = $ScoreEarned

func _ready():
	pass 


func show_score_modified(score : int, delay : float) -> void:
	var tween = create_tween()
	if score > 0:
		tween.tween_property($GoodScoreAudio, "playing", true, 0).set_delay(delay)
	elif score == 0:
		tween.tween_property($NeutralScoreAudio, "playing", true, 0).set_delay(delay)
	else:
		tween.tween_property($BadScoreAudio, "playing", true, 0).set_delay(delay)

	tween.tween_property(label, "modulate", Color.white , 0.75)
	label.text = ("+" if (score >= 0) else "") + str(score)
	tween.tween_property(label, "modulate", Color.transparent, 0.5)
