extends Control


onready var left_panel = $CanvasLayer/LeftPanel
onready var right_panel = $CanvasLayer/RightPanel


func set_turn(is_player_one_turn):
	if is_player_one_turn:
		left_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		right_panel.mouse_filter = Control.MOUSE_FILTER_STOP

	else:
		left_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		right_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
