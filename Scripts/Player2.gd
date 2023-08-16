extends CharacterBody2D
@export var move_speed : float = 600.0
@export var jump_force : float = 800.0
@export var gravity : float = 800.0
@export var fall_force : float = 800.0
@export var direction = -1
@export var size = 0.2
@export var grab_animation = false
@export var can_move = true

var fast_fall : bool = false
var doublejump : bool = false
var spawn
var isgrabbed = false
var p_1 = preload("res://Player_1_grabbed.tscn")
var p_1_ragdoll = preload("res://Player_1_ragdoll.tscn")

var sfx = preload("res://audio.tscn")
var audio_jump = preload("res://SFX/Jump.wav")
var audio_throw = preload("res://SFX/throw.wav")
var audio_grab = preload("res://SFX/grab.wav")

func _ready():
	get_node( "Sprite2D").scale.x = size  * direction
	get_node("Hitbox").scale.x = direction

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta 
	
	if is_on_floor():
		fast_fall = false
		doublejump = false
		
	if can_move == true:
		velocity.x = 0
		$AnimationPlayer.play("idle")
	
	#we don't want the player to move during the grab animation 
	#so the script only reads inputs when not doing the grab animation
	if can_move == true:
		if Input.is_action_pressed("P2L"):
			velocity.x = -move_speed
			direction = -1
			get_node( "Sprite2D").scale.x = size  * direction
			get_node("Hitbox").scale.x = direction
			if has_node("Player_1_grabbed"):
				get_node("Player_1_grabbed").scale.y = abs(get_node("Player_1_grabbed").scale.y) * direction
			
		if Input.is_action_pressed("P2R"):
			velocity.x = move_speed
			direction = 1
			get_node("Sprite2D").scale.x = size  * direction
			get_node("Hitbox").scale.x = direction
			if has_node("Player_1_grabbed"):
				get_node("Player_1_grabbed").scale.y = abs(get_node("Player_1_grabbed").scale.y) * direction
		
		if Input.is_action_just_pressed("P2U") and (is_on_floor() == true or doublejump == false):
			#generates sound for the jump
			var vase_jump = sfx.instantiate() as AudioStreamPlayer2D
			var audio = audio_jump
			vase_jump.stream = audio
			vase_jump.global_position = self.global_position
			get_parent().add_sibling(vase_jump)	
			
			velocity.y = -jump_force
			if is_on_floor() == false:
				doublejump = true
		
		if Input.is_action_just_pressed("P2D") and is_on_floor() == false and fast_fall == false:
			fast_fall = true
			velocity.y = fall_force
		
		#plays the grab animation
		if Input.is_action_just_pressed("P2Grab") and isgrabbed == false:
			#grab sound
			var vase_grab = sfx.instantiate() as AudioStreamPlayer2D
			var audio = audio_grab
			vase_grab.stream = audio
			vase_grab.global_position = self.global_position
			get_parent().add_sibling(vase_grab)
			
			$AnimationPlayer.play("Grab")
			if is_on_floor():
				velocity.x = 0
		
		#throws a newly spawned ragdoll
		if  Input.is_action_just_pressed("P2Throw") and isgrabbed == true:
			#throw sound
			var vase_throw = sfx.instantiate() as AudioStreamPlayer2D
			var audio = audio_throw
			vase_throw.stream = audio
			vase_throw.global_position = self.global_position
			get_parent().add_sibling(vase_throw)	
			
			var ragdoll = p_1_ragdoll.instantiate() as RigidBody2D
			ragdoll.position = self.global_position + Vector2(0,-150) 
			ragdoll.linear_velocity =  Vector2(get_parent().player1STAMINA * direction,-500) 
			ragdoll.angular_velocity =  3
			remove_child(spawn)
			ragdoll.request_ready()
			add_sibling(ragdoll)
			isgrabbed = false

	move_and_slide()

#spawns grabbed sprite of opposing player
func spawn_grabbed():
	spawn = p_1.instantiate() 
	spawn.position = Vector2(0,-50)  
	add_child(spawn)
	isgrabbed = true
	
func addpoints(points):
	get_parent().addpointsP2(points)
