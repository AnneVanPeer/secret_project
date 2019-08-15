extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$playerTest2.connect("interaction", $henk1, "_on_player_interaction")
	$playerTest2.connect("interaction", $henk2, "_on_player_interaction")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
