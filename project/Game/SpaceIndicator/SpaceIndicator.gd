## This is the node that glows that indicate the tile can be dropped here.
extends Node2D

onready var space_indicators := $SpaceIndicators

var neighbors := []

func _process(_delta):
	if neighbors.size() > 0:
		for i in range(space_indicators.get_child_count()):
			if i >= neighbors.size():
				space_indicators.get_child(i).visible = false
			else:
				space_indicators.get_child(i).visible = true
				space_indicators.get_child(i).global_position = neighbors[i].global_position


func move(new_position: Vector2) -> void:
	global_position = new_position
	visible = true


func hide() -> void:
	visible = false
