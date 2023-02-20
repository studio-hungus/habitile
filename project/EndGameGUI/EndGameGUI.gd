extends Control	


onready var _win_state_text = find_node("WinState")
onready var _draw_sound = find_node("DrawSound")
onready var _win_sound = find_node("WinSound")


func display_gameover_screen(end_state):
	if end_state == Game.EndState.DRAW:
		_display_draw()
	else:
		_display_win(end_state)


func _display_draw():
	_win_state_text.text = ("DRAW")
	_draw_sound.play()


func _display_win(end_state):
	if end_state == Game.EndState.LEFT_WIN:
		_win_state_text.text = ("player one wins")
	elif end_state == Game.EndState.RIGHT_WIN:
		_win_state_text.text = ("player two wins")
	
	_win_sound.play()


func _on_PlayAgain_pressed():
	var _current_scene = get_tree().reload_current_scene()


func _on_QuitGame_pressed():
	get_tree().quit()
