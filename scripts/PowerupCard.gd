extends Control

signal selected(item)
@export var hovered = false
var tween: Tween = null
var item : Item = Items.make_item(Items.random())
@onready var nameLabel : RichTextLabel = $NameLabel
@onready var descLabel : RichTextLabel = $DescriptionLabel

func _ready():
	assert(OK == $Button.connect("pressed", Callable(self, "_on_click")))
	assert(OK == $Button.connect("mouse_entered", Callable(self, "_on_mouse_hover").bind(true)))
	assert(OK == $Button.connect("mouse_exited", Callable(self, "_on_mouse_hover").bind(false)))
		
	
func _process(delta):
	nameLabel.text = item.name
	descLabel.text = item.description
	pass
	
func _on_click():
	emit_signal("selected", Items.ItemType.MAX_HEALTH_UP)
	
func _on_mouse_hover(is_hovered):
	hovered = is_hovered
	print(is_hovered)
	var hover_scale = 1.085
	
	if tween:
		tween.kill()
	tween = create_tween()
	if hovered:
		tween.tween_property(self, "scale", Vector2.ONE * hover_scale, 0.1)
	else:
		tween.tween_property(self, "scale", Vector2.ONE, 0.2)
	tween.play()
