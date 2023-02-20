extends Control


var max_health = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = Player.max_health
	$HealthLabel.rect_size = $HealthBar.rect_size
	$HealthLabel.rect_position = $HealthBar.rect_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$StageLabel.text = "Level %s" % GameState.level
	
	$HealthBar.value = Player.health
	$HealthLabel.text = "%s/%s" % [Player.health, Player.max_health]
	if max_health != Player.max_health:
		var scale = float(Player.max_health) / max_health
		print(scale)
		$HealthBar.rect_size.x *= scale
		$HealthLabel.rect_size.x *= scale
		max_health = Player.max_health
		