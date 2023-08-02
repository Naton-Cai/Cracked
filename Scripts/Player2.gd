extends CharacterBody2D
@export var move_speed : float = 600.0
@export var jump_force : float = 800.0
@export var gravity : float = 800.0
@export var fall_force : float = 800.0
@export var direction = -1
@export var size = 0.2
@export var grab_animation = false

var fast_fall : bool = false
var doublejump : bool = false
var p_1 = preload("res://Player_1_Grabbed.tscn")
var p_1_ragdoll = preload("res://Player_1_ragdoll.tscn")
var spawn = p_1.instantiate() 
var isgrabbed = false


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta 
	
	if is_on_floor():
		fast_fall = false
		doublejump = false
		if grab_animation == false:
			velocity.x = 0
	
	if grab_animation == false:
		if Input.is_action_pressed("P2L"):
			velocity.x = -move_speed
			direction = -1
			get_node( "Sprite2D").scale.x = size  * direction
			get_node("Hitbox").scale.x = direction
			if has_node("Player_1_Grabbed"):
				get_node("Player_1_Grabbed").scale.y = abs(get_node("Player_1_Grabbed").scale.y) * direction
			
		if Input.is_action_pressed("P2R"):
			velocity.x = move_speed
			direction = 1
			get_node("Sprite2D").scale.x = size  * direction
			get_node("Hitbox").scale.x = direction
			if has_node("Player_1_Grabbed"):
				get_node("Player_1_Grabbed").scale.y = abs(get_node("Player_1_Grabbed").scale.y) * direction
		
		if Input.is_action_just_pressed("P2U") and (is_on_floor() == true or doublejump == false):
				velocity.y = -jump_force
				if is_on_floor() == false:
					doublejump = true
		
		if Input.is_action_just_pressed("P2D") and is_on_floor() == false and fast_fall == false:
			fast_fall = true
			velocity.y = fall_force
		
		if Input.is_action_just_pressed("P2Grab") and isgrabbed == false:
			$AnimationPlayer.play("Grab")
		
		if  Input.is_action_just_pressed("P2Throw") and isgrabbed == true:
			var ragdoll = p_1_ragdoll.instantiate() as RigidBody2D
			ragdoll.position = self.global_position + Vector2(0,-150) 
			ragdoll.linear_velocity =  Vector2(700 * -direction,-500) 
			ragdoll.angular_velocity =  3
			remove_child(spawn)
			add_sibling(ragdoll)
			isgrabbed = false

	move_and_slide()


func spawn_grabbed():
	spawn.position = Vector2(0,-50)  
	add_child(spawn)
	isgrabbed = true
