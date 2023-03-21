extends Node

const pop_text = preload("res://scenes/PopText.tscn")

func make_pop_text(text, position, color):
	var p = pop_text.instantiate()
	var label = p.get_child(0)
	label.text = text
	label.add_theme_color_override("font_color", color)
	p.position = position
	return p
