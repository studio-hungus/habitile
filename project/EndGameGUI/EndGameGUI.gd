extends Control


onready var _game_over_label = find_node("GameOverLabel")
onready var _animation_player = find_node("AnimationPlayer")
onready var _win_gradient := find_node("WinGradient")
onready var _left_score_label := find_node("ScoreLeftLabel")
onready var _right_score_label := find_node("ScoreRightLabel")
onready var _button_click := find_node("ButtonClick")
onready var _play_again_button := find_node("PlayAgainButton")
onready var _quit_button := find_node("QuitGameButton")


func display_gameover_screen(end_state, left_score: String, right_score: String) -> void:
	_left_score_label.text = left_score
	_right_score_label.text = right_score
	if end_state == Game.EndState.DRAW:
		_display_draw()
	else:
		_display_win(end_state)


func _display_draw() -> void:
	_win_gradient.visible = false
	_animation_player.play("TieWin")
	_game_over_label.text = "DRAW"


func _display_win(end_state) -> void:
	_win_gradient.visible = true
	_game_over_label.text = "Congratulations"
	if end_state == Game.EndState.LEFT_WIN:
		_animation_player.play("LeftWin")
		_win_gradient.rect_scale = Vector2(1,1)
	elif end_state == Game.EndState.RIGHT_WIN:
		_win_gradient.rect_scale = Vector2(-1,1)
		_animation_player.play("RightWin")


func _on_PlayAgain_pressed() -> void:
	_button_click.play()
	_disable_buttons()
	yield(_button_click,"finished")
	var _current_scene = get_tree().reload_current_scene()


func _on_QuitGameButton_pressed() -> void:
	_button_click.play()
	_disable_buttons()
	yield(_button_click,"finished")
	var _current_scene = get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")


func _disable_buttons() -> void:
	_play_again_button.disabled = true
	_quit_button.disabled = true
