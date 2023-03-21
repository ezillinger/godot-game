extends Node

enum MainState {
	MAIN_MENU,
	GAMEPLAY,
	GAME_OVER,
	PAUSE,
	CHOOSE_POWERUP,
}

@export var main_state = MainState.MAIN_MENU

@export var level = 0

const screen_dims = Vector2(1920, 1080)

enum ItemType {
	MAX_HEALTH_UP,
	SHOT_SPEED_UP,
	PIERCING_UP,
	NUM_TYPES,
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
