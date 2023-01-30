extends Control

onready var left_panel = $CanvasLayer/LeftPanel as Control
onready var right_panel = $CanvasLayer/RightPanel as Control

func set_turn(is_player_one_turn):
	if is_player_one_turn:
		right_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		left_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if not is_player_one_turn:
		left_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		right_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#panel.mouse_filter = Control.MOUSE_FILTER_STOP
	
