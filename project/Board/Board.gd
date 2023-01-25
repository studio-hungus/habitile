extends Node2D

export var width := 1
export var height := 1

func _ready():
	pass


func get_empty_spaces()-> Array:
	return [$EmptySpace]
