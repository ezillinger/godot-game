extends MeshInstance2D

export var speed = 1000.0
export var shot_speed = 1.5
export var health = 100
export var dead = false
export var invincible = false
export var flash = false

var direction = Vector2.UP

const bullet = preload("res://scenes/Bullet.tscn")
const invincibility_time = 0.5
const flash_time = 0.15

var time_since_last_shot = 0.0
var time_since_last_hit = 0.0

func _ready():
	hide()
	
func update_shaders():
	var mat = get_material()
	if flash:
		mat.set_shader_param("flash_amount", 1.0)
		mat.set_shader_param("flash_color", Color.white)
		modulate = Color.white
	elif invincible:
		mat.set_shader_param("flash_amount", 0.5)
		mat.set_shader_param("flash_color", Color(0.0, 0.0, 0.0, 0.0))
	else:
		mat.set_shader_param("flash_amount", 0.0)
		modulate = Color.white


func hit(damage):
	if not invincible:
		time_since_last_hit = 0.0
		health -= damage
		flash = true
		invincible = true
		if health <= 0:
			dead = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	time_since_last_shot += delta
	time_since_last_hit += delta
	
	var mouse_position = get_viewport().get_mouse_position();
	
	direction = (mouse_position - position).normalized()
	
	rotation = atan2(direction.y, direction.x) + PI / 2
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
		
		
	velocity = velocity.normalized() * speed * delta;
	position += velocity
	
	var seconds_per_shot = 1 / shot_speed
	if Input.is_action_pressed("shoot") and time_since_last_shot >= seconds_per_shot:
		var b = bullet.instance()
		b.direction = direction
		b.position = self.position
		get_parent().add_child(b)
		time_since_last_shot = 0.0
		
	if time_since_last_hit > invincibility_time:
		invincible = false
	if time_since_last_hit > flash_time:
		flash = false
		
	update_shaders()

func _on_Area2D_area_entered(area):
	return
	print(area)
	if area.name.begins_with("@Enemy"):
		health -= 10
		if health <= 0:
			dead = true
