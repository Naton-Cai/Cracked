extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.play()
	await self.finished
	self.queue_free()
