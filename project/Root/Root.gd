extends Control


onready var audio_player := get_node("TitleScreen/AudioStreamPlayer")


func _ready() -> void:
	randomize()
	audio_player.stream_paused = true
	audio_player.autoplay = false
