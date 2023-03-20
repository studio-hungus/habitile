extends Control


signal play_again_button_pressed


onready var _tween = find_node("Tween")
onready var _left_panel = find_node("LeftPanel")
onready var _right_panel = find_node("RightPanel")
onready var _left_player_indicator = find_node("LeftTurnIndicator")
onready var _right_player_indicator = find_node("RightTurnIndicator")
onready var _left_player_fade = find_node("LeftOverlay")
onready var _right_player_fade = find_node("RightOverlay")
onready var _end_game_gui = load("res://EndGameGUI/EndGameGUI.tscn")
onready var _end_game_canvas = find_node("EndGameCanvas")
onready var _left_player_score_label = find_node("LeftPlayerScore")
onready var _right_player_score_label = find_node("RightPlayerScore")





func set_is_left_player_turn(value : bool) -> void:
	if value:
		_left_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_right_panel.mouse_filter = Control.MOUSE_FILTER_STOP

		_tween_alpha(_right_player_fade, 1.0)
		_tween_alpha(_left_player_fade, 0.0)
		_tween_alpha(_left_player_indicator, 1.0)
		_tween_alpha(_right_player_indicator, 0.0)
	else:
		_left_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		_right_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

		_tween_alpha(_left_player_fade, 1.0)
		_tween_alpha(_right_player_fade, 0.0)
		_tween_alpha(_left_player_indicator, 0.0)
		_tween_alpha(_right_player_indicator, 1.0)


func display_gameover(end_state) -> void:
	_left_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	_right_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	_tween_alpha(_left_player_indicator, 0.0)
	_tween_alpha(_right_player_indicator, 0.0)

	var _end_game_gui_instance = _end_game_gui.instance()
	_end_game_canvas.add_child(_end_game_gui_instance)
	_end_game_gui_instance.display_gameover_screen(end_state)


func _tween_alpha(node: Node, value: float) -> void:
	if node.modulate[3] != value:
		_tween.interpolate_property(node, "modulate",
			Color(1.0, 1.0, 1.0, 1.0 - value), Color(1.0, 1.0, 1.0, value), 0.5,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		_tween.start()
		
		
func update_score(left_score : int, right_score : int):
	_right_player_score_label.text = "%d" % right_score
	_left_player_score_label.text = "%d" % left_score


func _on_PlayAgainButton_pressed() -> void:
	emit_signal("play_again_button_pressed")
