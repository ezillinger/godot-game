extends Control

signal selected(item)
export var hovered = false

func _ready():
	assert(OK == $Button.connect("pressed", self, "_on_click"))
	assert(OK == $Button.connect("mouse_entered", self, "_on_mouse_hover", [true]))
	assert(OK == $Button.connect("mouse_exited", self, "_on_mouse_hover", [false]))
		
	
func _process(delta):
	pass
	
func _on_click():
	emit_signal("selected", Items.ItemType.MAX_HEALTH_UP)
	
func _on_mouse_hover(is_hovered):
	hovered = is_hovered
	print(is_hovered)
	var hover_scale = 1.085
	
	$Tween.remove_all()
	if hovered:
		$Tween.interpolate_property($".", "rect_scale", Vector2.ONE, Vector2.ONE * hover_scale, 0.1)
	else:
		$Tween.interpolate_property($".", "rect_scale", Vector2.ONE * hover_scale, Vector2.ONE, 0.2)
	$Tween.start()
