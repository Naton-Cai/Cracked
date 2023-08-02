class_name hurtbox
extends Area2D

#func _init() -> void:
	#collision_layer = 4
	#collision_mask = 8
	
func _ready() -> void:
	self.area_entered.connect(self._on_area_entered)

func _on_area_entered(hitbox: hitbox) -> void:
	#print("HURT")
	if hitbox == null:
		return
	if get_parent().grab_animation == false:
		get_parent().queue_free()
	if get_parent().grab_animation == true:
		print("PUSHED", get_parent())
		get_parent().velocity.x = get_parent().direction * -500
	else:
		return
