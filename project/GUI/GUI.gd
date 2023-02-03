extends Control


onready var left_panel = $CanvasLayer/LeftPanel
onready var right_panel = $CanvasLayer/RightPanel
onready var gameover_label = $CanvasLayer/GameOverLabel

var style_active = StyleBoxFlat.new()
var style_inactive = StyleBoxFlat.new()


func _ready():
	style_active.set_bg_color(Color("#ADD8E6"))
	gameover_label.visible = false

func set_is_left_player_turn(value : bool) -> void:
	if value:
		left_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		right_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		left_panel.add_stylebox_override("panel", style_active)
		right_panel.add_stylebox_override("panel", style_inactive)
	else:
		left_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		right_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		left_panel.add_stylebox_override("panel", style_inactive)
		right_panel.add_stylebox_override("panel", style_active)


func display_gameover():
	left_panel.add_stylebox_override("panel", style_inactive)
	left_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	right_panel.add_stylebox_override("panel", style_inactive)
	right_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	gameover_label.visible = true
