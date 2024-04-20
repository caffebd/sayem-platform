extends CanvasLayer

var my_crystal = 0
var game_time = 10
var fly_time = 5

func _ready():
	$coinTimer.start()
	$game_timer.start()
	$time_label.text = "Time: "+str(game_time)
	GlobalSignals.connect("fly_power", self, "_fly_power")
	GlobalSignals.connect("change_score", self, "_change_score")
	GlobalSignals.connect("sign_show",self, "_sign_show")
	GlobalSignals.connect("sign_hide", self, "_sign_hide")

func _sign_show(text):
	$signText.text = text
	$signText.visible = true

func _sign_hide():
	$signText.visible = false

func _change_score():
	my_crystal += 1
	$Score_Label.text = "Crystal: "+str(my_crystal)

func _on_coinTimer_timeout():
	GlobalSignals.emit_signal("load_coin")
	$coinTimer.start()

func _on_game_timer_timeout():
	game_time -= 1
	$time_label.text = "Time: "+str(game_time)
	if game_time == 0:
		$game_timer.stop()
		$coinTimer.stop()
		GlobalSignals.emit_signal("coin_destroy")

func _fly_power():
	$flyLabel.text = ""+str(fly_time)
	$flyTimer.start()

func _on_flyTimer_timeout():
	fly_time -= 1
	$flyLabel.text = ""+str(fly_time)
	if fly_time == 0:
		$flyTimer.stop()
		GlobalVars.fly_power = false
