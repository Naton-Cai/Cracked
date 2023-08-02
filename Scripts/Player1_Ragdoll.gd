extends RigidBody2D

func _physics_process(_delta):
	#print(self.linear_velocity)
	print(get_parent())
	if self.linear_velocity <= Vector2(0.1,0.1) and self.linear_velocity >= Vector2(-0.1,-0.1):
		print("STOPPED1")
		if get_parent().has_method("P1Damage"):
			if get_parent().P1Damage(5) > 0 and get_parent().has_method("spawnP1"):
				get_parent().spawnP1(self.global_position + Vector2(0,-50))  
			self.queue_free()

