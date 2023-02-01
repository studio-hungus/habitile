extends Control


onready var left_panel = $CanvasLayer/LeftPanel
onready var right_panel = $CanvasLayer/RightPanel

var style_active = StyleBoxFlat.new()
var style_inactive = StyleBoxFlat.new()

func _ready():
	style_active.set_bg_color(Color("#ADD8E6"))

func set_turn(is_player_one_turn):
	if is_player_one_turn:
		left_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		right_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		left_panel.add_stylebox_override("panel", style_active)
		right_panel.add_stylebox_override("panel", style_inactive)
	else:
		left_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		right_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		left_panel.add_stylebox_override("panel", style_inactive)
		right_panel.add_stylebox_override("panel", style_active)
