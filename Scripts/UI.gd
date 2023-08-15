extends Sprite2D
var original_pos = self.position
var damage = false
var shake_strength
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if damage:
		self.position =  original_pos + Vector2(randf_range(-shake_strength, shake_strength),randf_range(-shake_strength, shake_strength))

func shake(time, stamina):
	damage = true
	shake_strength = stamina/120
	await get_tree().create_timer(time).timeout
	damage = false
	self.position =  original_pos
	pass
	
