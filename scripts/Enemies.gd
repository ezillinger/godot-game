extends Node

const enemy = preload("res://scenes/Enemy.tscn")

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass
	
func spawn_wave(wave):
	var num_enemies = 10 * wave
	for _i in range(num_enemies):
		var e = enemy.instance()
		e.position = Vector2(1920 * randf(), 1080 * randf())
		add_child(e)
