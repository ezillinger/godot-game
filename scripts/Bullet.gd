extends Area2D
class_name Bullet

export var direction = Vector2.LEFT
export var speed = 500.0
export var damage = 50.0
export var pierces = 1

export var targets_player = false

func _ready():
	pass

func _process(delta):
	position += direction * speed * delta

func die():
	self.queue_free()

func _on_Area2D_area_entered(area):
	if targets_player and area.name == "Player" or (!targets_player and area.name.begins_with("@Enemy")):
		pierces -= 1
		if pierces == 0:
			self.call_deferred("die")
