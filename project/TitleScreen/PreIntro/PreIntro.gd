extends Control


onready var _animation_player := find_node("AnimationPlayer")
onready var _fade := find_node("Fade")


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == 1:
				_animation_player.play("Fade")


func invisible():
	_fade.visible = false


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
