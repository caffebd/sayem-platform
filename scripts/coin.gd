extends RigidBody2D

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("change_score")
		queue_free()

