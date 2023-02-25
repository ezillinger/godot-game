extends KinematicBody2D

export var speed = 1000.0
export var shots_per_second = 3.5
export var shot_speed = 1.5
export var health = 100
export var max_health = 100
export var dead = false
export var invincible = false
export var flash = false
export var pickup_radius = 225.0
export var piercing = 1
export var level = 0

var direction = Vector2.UP

var experience = 0.0
var max_experience = 10.0

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
		modulate = Color.white * 1.0


func hit(hit_damage, where):
	if not invincible:
		get_parent().add_child(Util.make_pop_text("%d" % hit_damage, where, Color.red))
		time_since_last_hit = 0.0
		health -= hit_damage
		flash = true
		invincible = true
		if health <= 0:
			health = 0
			dead = true

func add_experience(value):
	experience += value
	if experience >= max_experience:
		experience -= max_experience
		var new_powerup = Powerups.random()
		Powerups.apply(new_powerup)
		print("New powerup ", new_powerup)
		level += 1
		max_experience += level * 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	time_since_last_shot += delta
	time_since_last_hit += delta
	
	var mouse_position = get_viewport().get_mouse_position()
	direction = (mouse_position - position).normalized()
	
	rotation = atan2(direction.y, direction.x) + PI / 2
	
	position.x = fmod(position.x + GameState.screen_dims.x, GameState.screen_dims.x)
	position.y = fmod(position.y + GameState.screen_dims.y, GameState.screen_dims.y)
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
		
		
	var distance = velocity.normalized() * speed * delta;
	var _collision = move_and_collide(distance)
	
	var seconds_per_shot = 1 / shots_per_second
	if Input.is_action_pressed("shoot") and time_since_last_shot >= seconds_per_shot:
		var b = bullet.instance()
		b.direction = velocity + direction * shot_speed
		b.position = position
		b.pierces = piercing
		get_parent().add_child(b)
		time_since_last_shot = 0.0
		
	if time_since_last_hit > invincibility_time:
		invincible = false
	if time_since_last_hit > flash_time:
		flash = false
		
	update_shaders()
