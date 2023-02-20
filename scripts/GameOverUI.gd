extends Control

signal restart
signal exit
signal main_menu

func _ready():
	pass 

func _on_RestartButton_pressed():
	emit_signal("restart")


func _on_ExitButton_pressed():
	emit_signal("exit")


func _on_MainMenuButton_pressed():
	emit_signal("main_menu")
