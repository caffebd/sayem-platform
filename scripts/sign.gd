extends Area2D

export var sign_text = ""

func _ready():
	pass


func _on_sign_body_entered(body):
	if body.is_in_group("player"):
		print(sign_text)
		GlobalSignals.emit_signal("sign_show", sign_text)


func _on_sign_body_exited(body):
	if body.is_in_group("player"):
		GlobalSignals.emit_signal("sign_hide")
