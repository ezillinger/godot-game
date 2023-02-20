extends Control

signal restart
signal exit

func _ready():
	pass 

func _on_NewGameButton_pressed():
	emit_signal("restart")

func _on_ExitButton_pressed():
	emit_signal("exit")

