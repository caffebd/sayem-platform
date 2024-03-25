extends Node2D

var coin_scene = preload("res://scenes/coin.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	GlobalSignals.connect("load_coin", self, "_load_coin")


func _load_coin():
	var coin = coin_scene.instance()
	$all_coin.add_child(coin)
	var random_pos = Vector2(rng.randi_range(40,800), rng.randi_range(0,0))
	coin.global_position = Vector2(random_pos.x, random_pos.y)
