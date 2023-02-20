extends Node2D

const MainState = GameState.MainState

func new_game():
	Player.health = 100.0
	Player.dead = false
	Player.position = GameState.screen_dims / 2.0
	Player.show()
	
	for enemy in $Enemies.get_children():
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
			
			
	if new_state == MainState.GAMEPLAY:
		get_tree().paused = false
	elif new_state == MainState.GAME_OVER:
		get_tree().paused = true
		$UI/GameOver.show()
	elif new_state == MainState.MAIN_MENU:
		get_tree().paused = true
		$UI/MainMenu.show()
	elif new_state == MainState.PAUSE:
		get_tree().paused = true
		$UI/PauseMenu.show()
		pass
	
func _ready():
	change_states(MainState.MAIN_MENU)

func _process(_delta):

	match GameState.main_state:
		MainState.GAMEPLAY:
			if Player.dead:
				change_states(MainState.GAME_OVER)
			if Input.is_action_just_pressed("pause"):
				change_states(MainState.PAUSE)
				
			var enemy_in_scene = self.find_node("@Enemy@*", true, false)
			if not enemy_in_scene:
				GameState.level += 1
				$Enemies
				$Enemies.spawn_wave(GameState.level)

					
		MainState.PAUSE:
			if Input.is_action_just_pressed("pause"):
				change_states(MainState.GAMEPLAY)
					
func _on_main_menu():
	change_states(MainState.MAIN_MENU)

func _on_restart():
	new_game()

func _on_exit():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _on_resume():
	change_states(MainState.GAMEPLAY)
