extends RigidBody2D
var flag = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta_):
	if(flag == false):
		self.linear_velocity = Vector2(randf_range(-1000,1000), randf_range(-1000,1000))
		flag = true
	pass
