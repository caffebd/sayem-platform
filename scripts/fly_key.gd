extends Area2D

func _ready():
	pass

func _on_fly_key_body_entered(body):
	queue_free()
	GlobalSignals.emit_signal("player_fly")
	GlobalSignals.emit_signal("fly_power")
