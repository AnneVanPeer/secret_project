extends KinematicBody2D

# Declare member variables here. Examples:
var speed = 96
var tile_size = 16

var last_position = Vector2()
var target_position = Vector2()
var movedir = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2(tile_size, tile_size)) #Make sure player is snapped to grid
	last_position = position
	target_position = position
	
func get_movedir():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
	if movedir.x != 0 && movedir.y != 0:
		movedir = Vector2.ZERO
		
func _process(delta):
	#MOVEMENT
	position += speed * movedir * delta
	if position.distance_to(last_position) >= tile_size: #if we've moved further than one space
		position = target_position
	if position == target_position:
		get_movedir()
		last_position = position
		target_position += movedir * tile_size
