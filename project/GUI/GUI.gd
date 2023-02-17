extends Control


signal play_again_button_pressed


onready var _tween = find_node("Tween")
onready var _left_panel = find_node("LeftPanel")
onready var _right_panel = find_node("RightPanel")
onready var _left_player_indicator = find_node("LeftTurnIndicator")
onready var _right_player_indicator = find_node("RightTurnIndicator")
onready var _gameover_label = find_node("GameOverLabel")
onready var _play_again_button = find_node("PlayAgainButton")
onready var _left_player_fade = find_node("LeftOverlay")
onready var _right_player_fade = find_node("RightOverlay")



func _ready():
	_gameover_label.visible = false
	_play_again_button.visible = false


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


func display_gameover():
	_left_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	_right_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	_tween_alpha(_left_player_indicator, 0.0)
	_tween_alpha(_right_player_indicator, 0.0)

	_gameover_label.visible = true
	_play_again_button.visible = true


func _tween_alpha(node: Node, value: float):
	if node.modulate[3] != value:
		_tween.interpolate_property(node, "modulate",
			Color(1.0, 1.0, 1.0, 1.0 - value), Color(1.0, 1.0, 1.0, value), 0.5,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		_tween.start()



func _on_PlayAgainButton_pressed():
	emit_signal("play_again_button_pressed")
