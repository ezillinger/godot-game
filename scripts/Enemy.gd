extends Area2D
class_name Enemy

export var health = 100
export var speed = 100
export var damage = 30

var forces = Vector2.ZERO

func _ready():
	pass
	
	
func _process(delta):
	if overlaps_area(Player.get_child(0)):
		Player.hit(damage)
	
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
	
	var new_pos = position + delta * forces
	position = new_pos
	forces *= 0.5


func _on_Enemy_area_entered(area):
	if area.name.begins_with("@Bullet"):
		print("ENEMY HIT BY BULLET")
		forces += (position - area.position).normalized() * 1000.0;
		health -= area.damage
		if health <= 0:
			self.queue_free()
	elif area.name.begins_with("@Enemy"):
		forces += (position - area.position).normalized() * 100.0;		
	

