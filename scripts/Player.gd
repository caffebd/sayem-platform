extends KinematicBody2D

export var speed = 350

export var jump_speed = -450
export var gravity = 1000

var pushed = false

var direction := Vector2.ZERO

var attacking = false

var used_portal = false

func _ready():
	GlobalSignals.connect("push_up", self, "_push_up")
	GlobalSignals.connect("fly_power", self, "_fly_power")
	GlobalSignals.connect("use_portal", self, "_use_portal")

func _input(event):
	
	direction.x = 0
	
	if Input.is_action_pressed("right"):
		$PlayerAnim.flip_h = false
		$attackNode.scale.x = 1
		direction.x += speed
		if not attacking:
			$PlayerAnim.play("walk")
		
	elif Input.is_action_pressed("left"):
		$PlayerAnim.flip_h = true
		$attackNode.scale.x = -1
		direction.x -= speed
		if not attacking:
			$PlayerAnim.play("walk")
	else:
		if not attacking:
			$PlayerAnim.play("Idle")
			
	if GlobalVars.fly_power == true:
		direction.y = 0
	if Input.is_action_pressed("jump"):
			direction.y -= speed
			
	
	if Input.is_action_pressed("down"):
				direction.y += speed
		
	if Input.is_action_just_pressed("ufo_attak"):
		GlobalSignals.emit_signal("ufo_attack")
	
	if Input.is_action_just_pressed("attack"):
		attacking = true
		$PlayerAnim.set_frame(0)
		$PlayerAnim.play("attack")
		
		$"%attackCollision".disabled = false

func _use_portal(new_position):
	direction = Vector2.ZERO
	visible = false
	call_deferred("_collision_off")
	var tween = create_tween()
	tween.tween_property(self, "global_position", new_position, 1.0)
	yield (tween, "finished")
	call_deferred("_collision_on")
	
	visible = true

func _collision_off():
	$PlayerCollision.disabled = true
	$"%attackCollision".disabled = true

func _collision_on():
	$PlayerCollision.disabled = false

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

func _on_PlayerAnim_animation_finished():
	if $PlayerAnim.animation == "attack":
		attacking = false
		$"%attackCollision".disabled = true
