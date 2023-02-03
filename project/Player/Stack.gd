extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tile_scene := load("res://Tile/Tile.tscn")
var deck = []

var hand_size = 3
var deck_size = 10
func _ready():
	var supply = $"../Supply"
	_make_tiles()
	print("----------",get_child_count())
	give_starting_hand(supply)
	print("----------",get_child_count())

func _make_tiles():
	for n in deck_size:
		var tile = Tile.new()
		add_child(tile)
	deck = (get_children())
	
func give_starting_hand(target):
	for n in hand_size:
		var tile = deck[0]
		remove_child(tile)
		target.add_child(tile)
		deck.pop_at(0)
		
