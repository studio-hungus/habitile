extends Control


signal play_again_button_pressed


onready var left_panel = $CanvasLayer/LeftPanel
onready var right_panel = $CanvasLayer/RightPanel
onready var gameover_label = $CanvasLayer/GameOverLabel
onready var play_again_button = $CanvasLayer/PlayAgainButton

var style_active = StyleBoxFlat.new()
var style_inactive = StyleBoxFlat.new()


func _ready():
	right_panel.get_child(2).modulate = Color("#00ffffff")
	
	style_active.set_bg_color(Color("#ADD8E6"))
	gameover_label.visible = false
	play_again_button.visible = false

func set_is_left_player_turn(value : bool) -> void:
	var tween = get_node("Tween")
	if value:
		left_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		right_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		left_panel.add_stylebox_override("panel", style_active)
		right_panel.add_stylebox_override("panel", style_inactive)
		
		tween.interpolate_property(right_panel.get_child(2), "modulate",
		Color("#ffffffff"), Color("#00ffffff"), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		tween.interpolate_property(left_panel.get_child(2), "modulate",
		Color("#00ffffff"), Color("#ffffffff"), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		
		tween.interpolate_property(left_panel.get_child(2), "modulate",
		Color("#ffffffff"), Color("#00ffffff"), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		tween.interpolate_property(right_panel.get_child(2), "modulate",
		Color("#00ffffff"), Color("#ffffffff"), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		
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
	play_again_button.visible = true


func _on_PlayAgainButton_pressed():
	emit_signal("play_again_button_pressed")
