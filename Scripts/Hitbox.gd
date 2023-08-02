class_name hitbox
extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _init() -> void:
	#collision_layer = 8
	#collision_mask = 4

func _ready() -> void:
	self.area_entered.connect(self._on_area_entered)

func _on_area_entered(hurtbox: hurtbox) -> void:
	print("HIT")
	if hurtbox == null:
		return
	if get_parent().has_method("spawn_grabbed") and hurtbox.get_parent().grab_animation == false:
		get_parent().spawn_grabbed()
