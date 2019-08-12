extends KinematicBody2D

export var speed = 10.0
export var tilesize = 16

onready var sprite = $Sprite
onready var shape = $CollisionShape2D

var initpos = Vector2()
var dir = Vector2()
var facing = "down"
var counter = 0.0

var moving = false

func _ready():
	initpos = position

func _physics_process(delta):
	if not moving:
		#set direction
		set_dir()
	elif dir != Vector2():
		#move
		move(delta)
	else: 
		moving = false
	if facing == "down":
		sprite.frame = 0
	elif facing == "up":
		sprite.frame = 12
	elif facing == "left":
		sprite.frame = 8
	elif facing == "right":
		sprite.frame = 4
		
func set_dir(): #set moving direction
	dir = get_dir()
	
	if dir.x != 0 or dir.y != 0:
		
		if dir.x > 0:
			facing = "right"
		elif dir.x < 0:
			facing = "left"
		elif dir.y > 0:
			facing = "down"
		else:
			facing = "up"
		
		moving = true
		initpos = position
		
func get_dir(): #user input
	var x = 0
	var y = 0
	
	if dir.y == 0:
		x = int(Input.is_action_pressed("ui_right"))- int(Input.is_action_pressed("ui_left"))
	if dir.x == 0:
		y = int(Input.is_action_pressed("ui_down"))- int(Input.is_action_pressed("ui_up"))
		
	return Vector2(x,y)
	
func move(delta):
	counter += delta * speed
	
	if counter >= 1.0:
		position = initpos + dir * tilesize
		counter = 0
		moving = false
	else:
		position = initpos + dir * tilesize * counter