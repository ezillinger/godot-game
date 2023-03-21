extends Node2D
class_name Item

const ItemType = GameState.ItemType

@export var type = ItemType.MAX_HEALTH_UP
@export var description = "A healthy and delicious lunch"
@export var pos_effects = "Max HP +1"
@export var negative_effects = ""
@export var image = preload("res://assets/hpup.png")

func _ready():
	pass
