extends Node2D

const time_to_live = 0.5

func _ready():
	assert(OK == $Timer.connect("timeout", self,"_onTimer_TimeOut"))
	$Timer.start(time_to_live)

func _process(delta):
	modulate.a = $Timer.time_left / time_to_live
	position.y -= delta * 80

func _onTimer_TimeOut():
	self.queue_free()
