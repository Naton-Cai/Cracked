class_name gembox
extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _init() -> void:
	#collision_layer = 8
	#collision_mask = 4

func _ready() -> void:
	self.area_entered.connect(self._on_area_entered)

func _on_area_entered(hurtbox: hurtbox) -> void:
	print("PICKED UP")
	print(hurtbox.name)
	if hurtbox == null:
		return
	if hurtbox.name == "Hurtbox":
		get_parent().queue_free()
