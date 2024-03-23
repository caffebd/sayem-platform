extends Area2D


func _on_cristal_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("change_score")
		queue_free()

