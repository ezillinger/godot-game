extends Node2D

const MainState = GameState.MainState
var time_in_level = 0.0

func new_game():
	Player.health = 100.0
	Player.dead = false
	Player.position = GameState.screen_dims / 2.0
	Player.show()
	
	for enemy in Enemies.get_children():
		enemy.queue_free()
	GameState.level = 0
	
	change_states(MainState.GAMEPLAY)

func change_states(new_state):
	var old_state = GameState.main_state
	GameState.main_state = new_state
	
	print("Changing from ", old_state, " to ", new_state)
	match old_state:
		MainState.GAME_OVER:
			$UI/GameOver.hide()
		MainState.MAIN_MENU:
			$UI/MainMenu.hide()
		MainState.PAUSE:
			$UI/PauseMenu.hide()
		MainState.CHOOSE_POWERUP:
			$UI/ItemUI.hide()
			
	var pause = false
	match new_state:
		MainState.GAMEPLAY:
			pause = false
		MainState.GAME_OVER:
			pause = true
			$UI/GameOver.show()
		MainState.MAIN_MENU:
			pause = true
			$UI/MainMenu.show()
		MainState.PAUSE:
			pause = true
			$UI/PauseMenu.show()
		MainState.CHOOSE_POWERUP:
			pause = true
			$UI/ItemUI.show()
	
	get_tree().paused = pause
		
		
func _ready():
	assert(OK == $UI/ItemUI/Card1.connect("selected", Callable(self, "_onItemSelect")))
	assert(OK == $UI/ItemUI/Card2.connect("selected", Callable(self, "_onItemSelect")))
	assert(OK == $UI/ItemUI/Card3.connect("selected", Callable(self, "_onItemSelect")))
	change_states(MainState.MAIN_MENU)
	
func _onItemSelect(item):
	Items.apply(item)
	change_states(MainState.GAMEPLAY)
	

func _process(delta):

	match GameState.main_state:
		MainState.GAMEPLAY:
			if Player.dead:
				change_states(MainState.GAME_OVER)
			if Input.is_action_just_pressed("pause"):
				change_states(MainState.PAUSE)
			
			time_in_level += delta
			if time_in_level > 10.0 or Enemies.get_child_count() == 0:
				GameState.level += 1
				Enemies.spawn_wave(GameState.level)
				time_in_level = 0.0

			if Player.experience > Player.max_experience:
				Player.experience -= Player.max_experience
				Player.max_experience = max(Player.level * 10, 10)
				Player.level += 1
				change_states(MainState.CHOOSE_POWERUP)
								
		MainState.PAUSE:
			if Input.is_action_just_pressed("pause"):
				change_states(MainState.GAMEPLAY)
					
func _on_main_menu():
	change_states(MainState.MAIN_MENU)

func _on_restart():
	new_game()

func _on_exit():
	get_tree().notification(NOTIFICATION_WM_CLOSE_REQUEST)

func _on_resume():
	change_states(MainState.GAMEPLAY)
