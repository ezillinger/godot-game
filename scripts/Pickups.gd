extends Node2D

const pickup = preload("res://scenes/Pickup.tscn")

func _ready():
	pass

func _process(delta):
	pass
	
func spawn(pos, level):
	var p = pickup.instantiate()
	
	p.position = pos
	p.value = level
	add_child(p)
