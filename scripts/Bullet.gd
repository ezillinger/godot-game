extends Area2D
class_name Bullet

export var direction = Vector2.LEFT
export var speed = 500.0
export var damage = 50.0
export var pierces = 1

export var targets_player = false

func _ready():
	pass

func _physics_process(delta):
	position += direction * speed * delta
	
	for body in get_overlapping_bodies():
		var is_player = body.name == "Player"
		var is_enemy = not is_player
		var hit = false
		if targets_player and is_player:
			hit = true
		elif not targets_player and is_enemy:
			hit = true
		
		if hit:
			body.hit(damage, position)
			pierces -= 1
			if pierces == 0:
				self.call_deferred("queue_free")

