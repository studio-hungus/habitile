extends Control	


onready var _win_state_text = find_node("WinState")


func display_gameover_screen(end_state):
	if end_state == Game.EndState.LEFT_WIN:
		_win_state_text.text = ("player one wins")
	elif end_state == Game.EndState.RIGHT_WIN:
		_win_state_text.text = ("player two wins")
	else:
		_win_state_text.text = ("tie")


func _on_PlayAgain_pressed():
	var _current_scene = get_tree().reload_current_scene()


func _on_QuitGame_pressed():
	get_tree().quit()
