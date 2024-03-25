extends Control

var my_crystal = 0

func _ready():
	$coinTimer.start()
	GlobalSignals.connect("change_score", self, "_change_score")

func _change_score():
	my_crystal += 1
	$Score_Label.text = "Crystal: "+str(my_crystal)

func _on_coinTimer_timeout():
	GlobalSignals.emit_signal("load_coin")
	$coinTimer.start()
