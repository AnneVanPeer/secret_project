extends Sprite

onready var ray = $RayCast2D
# Declare member variables here. Examples:
export var moveSpeed = 256
var tile_size = 16

var last_position = Vector2()
var target_position = Vector2()
var movedir = Vector2()
var facing = "down"
var moving =  false

var walkingDown
var walkingUp
var walkingLeft
var walkingRight

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
	if movedir != Vector2.ZERO:
		ray.cast_to = movedir * tile_size / 2
		
	if movedir.x > 0:
		facing = "right"
	if movedir.x < 0:
		facing = "left"
	if movedir.y > 0:
		facing = "down"
	if movedir.y < 0:
		facing = "up"
		

		
func _process(delta):
	
	#MOVEMENT
	if ray.is_colliding():
		position = last_position
		target_position = last_position
	else: 
		position += moveSpeed * movedir * delta
	if movedir == Vector2.ZERO:
		$AnimationPlayer.stop(true)
	if position.distance_to(last_position) >= tile_size: #if we've moved further than one space
		position = target_position
	if position == target_position:
		get_movedir()
		last_position = position
		target_position += movedir * tile_size
		
	if facing == "down":
		frame = 0
	elif facing == "up":
		frame = 12
	elif facing == "left":
		frame = 8
	elif facing == "right":
		frame = 4
