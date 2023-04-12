extends Control


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == 1:
				$AnimationPlayer.play("Fade")
				
func invisible():
	$ColorRect.visible = false


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
