extends Control


var max_health = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = Player.max_health
	$HealthLabel.size = $HealthBar.size
	$HealthLabel.position = $HealthBar.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	$StageLabel.text = "Level %s" % GameState.level
	
	$HealthBar.value = Player.health
	$HealthLabel.text = "%s/%s" % [Player.health, Player.max_health]
	
	$ExperienceBar.value = Player.experience
	$ExperienceBar.max_value = Player.max_experience
	
	var ms = Time.get_ticks_msec()
	var s = ms / 1000
	var m = s / 60
	
	$TimeLabel.text = "%02d:%02d" % [m % 60, s % 60]
	
	if max_health != Player.max_health:
		var scale_ = float(Player.max_health) / max_health
		$HealthBar.size.x *= scale_
		$HealthLabel.size.x *= scale_
		max_health = Player.max_health
