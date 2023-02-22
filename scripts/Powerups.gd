extends Node2D

enum Type {
	MAX_HEALTH_UP,
	SHOT_SPEED_UP,
	PIERCING_UP,
	NUM_TYPES
}

func apply(type):
	match type:
		Type.MAX_HEALTH_UP:
			Player.max_health += 20.0
		Type.PIERCING_UP:
			Player.piercing += 1
		Type.SHOT_SPEED_UP:
			Player.shots_per_second += 1.0

static func random():
	return int(round(rand_range(0.0, float(Type.NUM_TYPES))))

func _ready():
	pass
