extends Control


signal play_music

onready var _animation_player := find_node("AnimationPlayer")
onready var _fade := find_node("Fade")
onready var _open_image := find_node("OpenImage")


func _ready() -> void:
	_animation_player.play("TextFadeIn")


func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == 1:
				_animation_player.play("Fade")


func invisible() -> void:
	_fade.visible = false
	_open_image.visible = false


func _on_AnimationPlayer_animation_finished(anim_name) -> void:
	if anim_name == "Fade":
		emit_signal("play_music")
		queue_free()
