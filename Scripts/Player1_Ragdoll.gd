extends RigidBody2D
var gem = preload("res://Gem.tscn")
var vase = preload("res://broken_vase_1.tscn")
var sfx = preload("res://audio.tscn")
var audio_break = preload("res://SFX/vase_break.wav")
var audio_collide = preload("res://SFX/collide.wav")
var audio_jump = preload("res://SFX/Jump.wav")
var audio_resist = preload("res://SFX/resist.wav")
var stun = 5.0
var timer
var collided = false
var start_distance = Vector2(0,0)

func _init():
	self.contact_monitor = true
	self.max_contacts_reported = 1
	stun = 2.0
	collided = false
	
func _ready():
	self.body_entered.connect(self._on_body_entered)
	start_distance = self.global_position
	
	timer = get_node("Timer")
	timer.timeout.connect(self._on_timeout)
	timer.set_wait_time(stun)
	timer.start()	
	
	
func _physics_process(_delta):
	#the recover system, pressing up allows the player to recover from a throw 
	#and potential not hit the wall at the cost of stamina
	if get_parent().player1HP > 0 and get_parent().has_method("spawnP1") and get_parent().has_method("P1Damage"):
		if  Input.is_action_just_pressed("P1U"):
			var vase_resist = sfx.instantiate() as AudioStreamPlayer2D
			var audio = audio_resist
			vase_resist.stream = audio
			vase_resist.global_position = self.global_position
			get_parent().add_sibling(vase_resist)
			
			if timer.time_left - 1.0 <= 0.0:
				timer.stop()
				timer.emit_signal("timeout")
				if collided == false:
					get_parent().player1STAMINA = min(2*get_parent().player1STAMINA, 3000.0)
			else:
				stun = timer.time_left - 0.1
				timer.set_wait_time(stun)
				timer.start()	
			
func _on_body_entered(node):
	
	if collided == false:
		collided = true
	
		#damage calcuations based of distance
		var travel_distance = self.global_position - start_distance
		var damage = (abs(travel_distance.x) + abs(travel_distance.y))/150 + 3	
		get_parent().player1STAMINA = min(1.5*get_parent().player1STAMINA, 3000.0)
		
		if get_parent().P1Damage(damage) <= 0:
			#generates 1-5 gems
			for i in range(randi_range(1,5)):
				var gem_object = gem.instantiate() 
				gem_object.position = self.global_position
				gem_object.linear_velocity =  Vector2(randf_range(250, -250),-900)
				gem_object.angular_velocity =  4
				get_parent().add_child(gem_object)

			#spanws the audio for the vase breaking
			var vase_break = sfx.instantiate() as AudioStreamPlayer2D
			var audio = audio_break
			vase_break.stream = audio
			vase_break.global_position = self.global_position
			get_parent().add_sibling(vase_break)	
						
			#generates the broke vase pieces
			var vase_object = vase.instantiate() 
			vase_object.position = self.global_position
			vase_object.rotation = self.rotation
			vase_object.request_ready()
			get_parent().add_child(vase_object)
			get_parent().respawnP1()
			
			self.queue_free()
			

	var vase_collide = sfx.instantiate() as AudioStreamPlayer2D
	var audio = audio_collide
	vase_collide.stream = audio
	vase_collide.global_position = self.global_position
	get_parent().add_sibling(vase_collide)	
		
		

func _on_timeout():
	var vase_jump = sfx.instantiate() as AudioStreamPlayer2D
	var audio = audio_jump
	vase_jump.stream = audio
	vase_jump.global_position = self.global_position
	get_parent().add_sibling(vase_jump)
	
	var direction
	if self.rotation == 0.0:
		direction = 1
	else:
		direction = self.rotation/abs(self.rotation)	
	get_parent().spawnP1(self.global_position + Vector2(0,-50), direction)
	self.queue_free()
