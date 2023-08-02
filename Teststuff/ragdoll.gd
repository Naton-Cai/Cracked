extends RigidBody2D
var player2 = preload("res://player_2.tscn")

func _physics_process(delta):
	#print(self.linear_velocity)
	print(get_parent())
	if self.linear_velocity <= Vector2(0.1,0.1) and self.linear_velocity >= Vector2(-0.1,-0.1):
		print("STOPPED")
		var player_2 = player2.instantiate()
		if get_parent().has_method("P2Damage"):
			if get_parent().P2Damage(5) > 0 and get_parent().has_method("spawnP2"):
				get_parent().spawnP2(self.global_position + Vector2(0,-50))  
			self.queue_free()
	

