extends Control


onready var _game_over_label = find_node("GameOverLabel")
onready var _draw_sound = find_node("DrawSound")
onready var _win_sound = find_node("WinSound")
onready var _animation_player = find_node("AnimationPlayer")
onready var _win_gradient := find_node("WinGradient")


func display_gameover_screen(end_state) -> void:
	if end_state == Game.EndState.DRAW:
		_display_draw()
	else:
		_display_win(end_state)


func _display_draw() -> void:
	_win_gradient.visible = false
	_game_over_label.text = "DRAW"
	_draw_sound.play()


func _display_win(end_state) -> void:
	_win_gradient.visible = true
	_game_over_label.text = "Congratulations"
	if end_state == Game.EndState.LEFT_WIN:
		_animation_player.play("LeftWin")
		_win_gradient.rect_scale = Vector2(1,1)
	elif end_state == Game.EndState.RIGHT_WIN:
		_win_gradient.rect_scale = Vector2(-1,1)
		_animation_player.play("RightWin")
	_win_sound.play()


func _on_PlayAgain_pressed() -> void:
	var _current_scene = get_tree().reload_current_scene()
