extends AnimatedSprite

onready var ray = $RayCast2D
# Declare member variables here. Examples:
export var moveSpeed = 256
var tile_size = 16

var last_position = Vector2()
var target_position = Vector2()
var movedir = Vector2()

var walkingDown
var walkingUp
var walkingLeft
var walkingRight

signal interaction(object_name)

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
		ray.cast_to = movedir * (tile_size / 2)
		
	if Input.is_action_pressed("ui_down"):
		walkingDown = true
		walkingLeft = false
		walkingRight = false
		walkingUp = false
	if Input.is_action_pressed("ui_up"):
		walkingDown = false
		walkingLeft = false
		walkingRight = false
		walkingUp = true
	if Input.is_action_pressed("ui_right"):
		walkingDown = false
		walkingLeft = false
		walkingRight = true
		walkingUp = false
	if Input.is_action_pressed("ui_left"):
		walkingDown = false
		walkingLeft = true
		walkingRight = false
		walkingUp = false
		
func _process(delta):
	
	#MOVEMENT
	if ray.is_colliding():
		position = last_position
		target_position = last_position
	else: 
		position += moveSpeed * movedir * delta
		
	if position.distance_to(last_position) >= tile_size: #if we've moved further than one space
		position = target_position
	if position == target_position:
		get_movedir()
		last_position = position
		target_position += movedir * tile_size
	
	if walkingDown == true:
		play("down")
	if walkingRight == true:
		play("right")
	if walkingLeft == true:
		play("left")
	if walkingUp == true:
		play("up")
		
	if movedir.x == 0 && movedir.y == 0:
		walkingDown = false
		walkingLeft = false
		walkingRight = false
		walkingUp = false
		stop()
	
	#Check on enter press to see if player is colliding with an interactable object.
	if Input.is_action_just_pressed("ui_accept"):
		if ray.is_colliding():
			var object_name = ray.get_collider().name
			emit_signal("interaction", object_name)
