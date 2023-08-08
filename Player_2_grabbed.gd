extends Sprite2D
var stun = 5.0
var timer
var sfx = preload("res://audio.tscn")
var audio_resist = preload("res://SFX/resist.wav")
var vase_resist
var audio
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Timer")
	timer.timeout.connect(self._on_timeout)
	timer.set_wait_time(stun)
	timer.start()	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#the recover system, pressing up allows the player to recover from a grab 
	#and potential not hit the wall at the cost of stamina
	if get_parent().get_parent().has_method("spawnP2"):
		if  Input.is_action_just_pressed("P2U"):
			vase_resist = sfx.instantiate() as AudioStreamPlayer2D
			audio = audio_resist
			vase_resist.stream = audio
			vase_resist.global_position = self.global_position
			get_parent().get_parent().add_sibling(vase_resist)
			
			if timer.time_left - 1.0 <= 0.0:
				timer.stop()
				timer.emit_signal("timeout")
				get_parent().get_parent().player2STAMINA = min(1.2*get_parent().get_parent().player2STAMINA, 3000.0)
			else:
				stun = timer.time_left - 0.5
				timer.set_wait_time(stun)
				timer.start()	

func _on_timeout():
	vase_resist = sfx.instantiate() as AudioStreamPlayer2D
	audio = audio_resist
	vase_resist.stream = audio
	vase_resist.global_position = self.global_position
	get_parent().get_parent().add_sibling(vase_resist)	
	
	var direction
	if self.rotation == 0.0:
		direction = 1
	else:
		direction = self.rotation/abs(self.rotation)
	get_parent().isgrabbed = false
	get_parent().get_parent().spawnP2(self.global_position + Vector2(0,-100), direction)
	self.queue_free()
