extends KinematicBody2D

export var speed = 350

export var jump_speed = -550
export var gravity = 900

var pushed = false

var direction := Vector2.ZERO

func _ready():
	GlobalSignals.connect("push_up", self, "_push_up")
	GlobalSignals.connect("fly_power", self, "_fly_power")

func _input(event):
	direction.x = 0
	if Input.is_action_pressed("right"):
		$PlayerAnim.flip_h = false
		direction.x += speed
		
	if Input.is_action_pressed("left"):
		$PlayerAnim.flip_h = true
		direction.x -= speed
	if GlobalVars.fly_power == true:
		direction.y = 0
		if Input.is_action_pressed("jump"):
			direction.y -= speed
		if Input.is_action_pressed("down"):
				direction.y += speed
	else:
			gravity = 900

func _push_up():
	pushed = true

func _process(delta):
	direction.y += gravity * delta
	if GlobalVars.fly_power == false:
		if Input.is_action_just_pressed("jump"):
			if is_on_floor() and not GlobalVars.fly_power:
				direction.y = jump_speed
	if pushed:
		direction.y = jump_speed/2
		pushed = false

	direction = move_and_slide(direction,  Vector2.UP)

func _fly_power():
	gravity = 0
	GlobalVars.fly_power = true



