extends RigidBody2D
var gem = preload("res://Gem.tscn")
var stun = 5.0
var timer
var collided = false

func _init():
	print("INIT")
	self.contact_monitor = true
	self.max_contacts_reported = 1
	stun = 2.0
	collided = false
	
func _ready():
	self.body_entered.connect(self._on_body_entered)
	timer = get_node("Timer")
	timer.timeout.connect(self._on_timeout)
	timer.set_wait_time(stun)
	timer.start()	
	
func _physics_process(_delta):
	if get_parent().player1HP > 0 and get_parent().has_method("spawnP2") and get_parent().has_method("P2Damage"):
		if  Input.is_action_just_pressed("P2U"):
			if timer.time_left - 1.0 <= 0.0:
				timer.stop()
				timer.emit_signal("timeout")
			else:
				stun = timer.time_left - 0.5
				timer.set_wait_time(stun)
				timer.start()	
		
func _on_body_entered(node):
	if collided == false:
		collided = true
		if get_parent().P2Damage(5) <= 0:
			#generates 1-5 gems
			for i in range(randi_range(1,5)):
				var gem_object = gem.instantiate() 
				gem_object.position = self.global_position
				gem_object.linear_velocity =  Vector2(randf_range(250, -250),-900)
				gem_object.angular_velocity =  4
				get_parent().add_child(gem_object)
				self.queue_free()	
			get_parent().respawnP2()
	
		

func _on_timeout():
	print("TIME")
	get_parent().spawnP2(self.global_position + Vector2(0,-50))
	self.queue_free()