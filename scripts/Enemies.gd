extends Node

const enemy = preload("res://scenes/Enemy.tscn")

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass
	
func spawn_wave(wave):
	var num_enemies = 1 * wave
	for i in range(num_enemies):
		var e = enemy.instantiate()
		var margin = 50
		var edge = 3 if randf() < 0.7 else 2
		var w = GameState.screen_dims.x
		var h = GameState.screen_dims.y
		match edge:
			0:
				e.position = Vector2(w * randf(), -margin)
			1:
				e.position = Vector2(w * randf(), h + margin)
			2:
				e.position = Vector2(-margin, h * randf())
			3:
				e.position = Vector2(w + margin, h * randf())
		e.level = wave
		add_child(e)
