extends Control


onready var audio_player := get_node("TitleScreen/AudioStreamPlayer")


func _ready():
	audio_player.stream_paused = true
	audio_player.autoplay = false
