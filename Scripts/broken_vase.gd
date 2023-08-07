extends Node2D


func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(self._on_timeout)
	timer.set_wait_time(5)
	timer.start()	

func _on_timeout():
	self.queue_free()
