extends KinematicBody2D

export var speed = 350

export var jump_speed = -450
export var gravity = 1000

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
	if Input.is_action_just_pressed("ufo_attak"):
		GlobalSignals.emit_signal("ufo_attack")

func _push_up():
	pushed = true

func _process(delta):
	direction.y += gravity * delta
	
	var is_grounded = $RayCast2D.is_colliding()
	
	if GlobalVars.fly_power == false:
		if Input.is_action_just_pressed("jump") and not GlobalVars.fly_power:
			if is_grounded:
				direction.y = jump_speed
	if pushed:
		direction.y = jump_speed/2
		pushed = false

	direction = move_and_slide(direction,  Vector2.UP)

func _fly_power():
	gravity = 0
	GlobalVars.fly_power = true



