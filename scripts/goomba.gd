extends KinematicBody2D

var GRAVITY = 900

var walk_speed = 100

var direction = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	direction = Vector2.ZERO
	direction.y += GRAVITY * delta
	if is_on_floor():
		direction.x += walk_speed
		
	direction = move_and_slide(direction,  Vector2.UP)
