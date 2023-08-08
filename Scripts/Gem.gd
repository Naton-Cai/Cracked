class_name gembox
extends Area2D
var sfx = preload("res://audio.tscn")
var audio_file = preload("res://SFX/gempickup.wav")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _init() -> void:
	#collision_layer = 8
	#collision_mask = 4

func _ready() -> void:
	self.area_entered.connect(self._on_area_entered)

func _on_area_entered(hurtbox: hurtbox) -> void:
	var gem_pickup = sfx.instantiate() as AudioStreamPlayer2D
	var audio = audio_file
	gem_pickup.stream = audio
	gem_pickup.global_position = self.global_position
	get_parent().add_sibling(gem_pickup)
	if hurtbox == null:
		return
	if hurtbox.name == "Hurtbox":
		get_parent().queue_free()
