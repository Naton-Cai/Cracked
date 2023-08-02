extends RigidBody2D

func _physics_process(_delta):
	if self.linear_velocity <= Vector2(0.1,0.1) and self.linear_velocity >= Vector2(-0.1,-0.1):
		print("STOPPED")
		if get_parent().has_method("P2Damage"):
			if get_parent().P2Damage(5) > 0 and get_parent().has_method("spawnP2"):
				get_parent().spawnP2(self.global_position + Vector2(0,-50))  
			self.queue_free()
