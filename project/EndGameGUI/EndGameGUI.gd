extends Control	


onready var _win_state_text = find_node("WinState")
onready var _win_tree = find_node("WinTree")
onready var _left_player_position = find_node("LeftPlayer")
onready var _right_player_position = find_node("RightPlayer")
onready var _draw_sound = find_node("DrawSound")
onready var _win_sound = find_node("WinSound")
onready var _animation_player = find_node("AnimationPlayer")
onready var _win_gradient := find_node("WinGradient")


func display_gameover_screen(end_state):
	if end_state == Game.EndState.DRAW:
		
		_display_draw()
		
	else:
		_display_win(end_state)


func _display_draw():
	_win_gradient.visible = false
	_win_state_text.text = ("DRAW")
	_draw_sound.play()


func _display_win(end_state):
	_win_gradient.visible = true
	if end_state == Game.EndState.LEFT_WIN:
		_win_state_text.text = ("Left Player Wins!")
		_animation_player.play("LeftWin")
		_win_gradient.rect_scale = Vector2(1,1)
	elif end_state == Game.EndState.RIGHT_WIN:
		_win_gradient.rect_scale = Vector2(-1,1)
		_win_state_text.text = ("Right Player Wins!")
		_win_tree.global_position = _right_player_position.global_position
		_animation_player.play("RightWin")
		_animation_player.play("RightWin")
	_win_sound.play()


func _on_PlayAgain_pressed():
	var _current_scene = get_tree().reload_current_scene()


func _on_QuitGame_pressed():
	get_tree().quit()
