extends GPUParticles2D

@export var radius = 20.0
@export var value = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	if value > 10:
		modulate = Color(1.3, 0.0, 0.0, 1.0)
	if value > 20:
		modulate = Color(0.0, 1.0, 0.7, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Player.position - position).length() < Player.pickup_radius:
		var diff = Player.position - position
		var dir = diff.normalized()
		var distance = diff.length()
		position += dir * 80000.0 / (distance*distance)
		
		if distance < radius:
			apply_and_die()
	
	
		
func apply_and_die():
	Player.add_experience(value)
	queue_free()
	
