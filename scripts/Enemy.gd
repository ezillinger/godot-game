extends CharacterBody2D
class_name Enemy

@export var health = 100
@export var speed = 100
@export var damage = 30
@export var level = 1
const pickup_chance = 0.5

var forces = Vector2.ZERO

func _ready():
	pass

func hit(hit_damage, where):
	health -= hit_damage
	get_parent().add_child(Util.make_pop_text("%d" % hit_damage, where, Color.WHITE))
	if health <= 0:
		if randf() < pickup_chance:
			Pickups.spawn(position, level)
		queue_free()
		
	return hit_damage
	
func _physics_process(delta):
	var dir = Vector2.ZERO
	if Player.visible:
		dir = (Player.position - self.position).normalized()
	if dir.x > 0:
		get_child(0).flip_h = false
	else:
		get_child(0).flip_h = true
		
	forces += dir * speed
	var rand_amt = randf_range(50.0, 200.0)
	forces += (Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * 40.0 + forces).normalized() * rand_amt
	
	var collision = move_and_collide(delta * forces)
	if collision:
		var hit_force = 1200.0
		if collision.get_collider_id() == Player.get_instance_id():
			collision.get_collider().hit(damage, position)
			hit_force *= 3.0
		forces += collision.get_normal() * hit_force
		# print(collision.get_instance_id() == Player.get_instance_id())
	forces *= 0.5
