extends Node2D

const item = preload("res://scenes/Item.tscn")
const ItemType = GameState.ItemType

const hp_up_image = preload("res://assets/hpup.png")

static func apply(type):
	match type:
		ItemType.MAX_HEALTH_UP:
			Player.max_health += 20.0
		ItemType.PIERCING_UP:
			Player.piercing += 1
		ItemType.SHOT_SPEED_UP:
			Player.shots_per_second += 1.0

static func random():
	return int(round(randf_range(0.0, float(ItemType.NUM_TYPES))))

static func make_item(type):
	var ret = item.instantiate()
	ret.type = type
	match type:
		ItemType.MAX_HEALTH_UP:
			ret.name = "Lunch"
			ret.description = "A healthy and delicious lunch"
			ret.image = hp_up_image
		ItemType.PIERCING_UP:
			ret.name = "A very pointy fork"
			ret.description = "Don't stab your eye out"
			ret.image = hp_up_image
		ItemType.SHOT_SPEED_UP:
			ret.name = "Elbow Grease"
			ret.description = "Made with real elbows"
			ret.image = hp_up_image
		ItemType.NUM_TYPES:
			assert(false)
	return ret
