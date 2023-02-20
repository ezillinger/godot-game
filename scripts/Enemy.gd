extends KinematicBody2D
class_name Enemy

export var health = 100
export var speed = 100
export var damage = 30

var forces = Vector2.ZERO

func _ready():
	pass

func hit(hit_damage):
	health -= hit_damage
	if health <= 0:
		queue_free()
	
func _process(_delta):
	pass #move_and_collide()
		# Player.hit(damage)
	
func _physics_process(delta):
	var dir = Vector2.ZERO
	if Player.visible:
		dir = (Player.position - self.position).normalized()
	if dir.x > 0:
		get_child(0).flip_h = false
	else:
		get_child(0).flip_h = true
		
	forces += dir * speed
	var rand_amt = rand_range(50.0, 200.0)
	forces += (Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)) * 40.0 + forces).normalized() * rand_amt
	
	var collision = move_and_collide(delta * forces)
	if collision:
		var hit_force = 1200.0
		if collision.collider.name == "Player":
			collision.collider.hit(damage)
			hit_force *= 3.0
		forces += collision.normal  * hit_force
		# print(collision.get_instance_id() == Player.get_instance_id())
	forces *= 0.5

