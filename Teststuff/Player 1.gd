extends CharacterBody2D

@export var move_speed : float = 600.0
@export var jump_force : float = 500.0
@export var gravity : float = 800.0
@export var fall_force : float = 800.0
@export var fast_fall : bool = false
var p_2 = preload("res://p_2.tscn")
var p_2_ragdoll = preload("res://p_2_ragdoll.tscn")
var spawn = p_2.instantiate() 
var isgrabbed = false
var direction = 1
var size = 0.8

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		fast_fall = false
		
	velocity.x = 0
	
	if Input.is_action_pressed("P1L"):
		velocity.x -= move_speed
		direction = -1
		get_node( "Sprite" ).scale.x = size  * direction
		get_node("Hitbox").scale.x = direction
		
	if Input.is_action_pressed("P1R"):
		velocity.x += move_speed
		direction = 1
		get_node( "Sprite" ).scale.x = size  * direction
		get_node("Hitbox").scale.x = direction
	
	if Input.is_action_just_pressed("P1U") and is_on_floor() == true:
			velocity.y = -jump_force
	
	if Input.is_action_just_pressed("P1D") and is_on_floor() == false and fast_fall == false:
		fast_fall = true
		velocity.y = fall_force
		
	if Input.is_action_just_pressed("SPAWN") and isgrabbed == false:
		$AnimationPlayer.play("Player 1 Grab")
	
	if  Input.is_action_just_pressed("THROW") and isgrabbed == true:
		var ragdoll = p_2_ragdoll.instantiate() as RigidBody2D
		ragdoll.position = self.global_position + Vector2(0,-150) 
		ragdoll.linear_velocity =  Vector2(700 * direction,-500) 
		ragdoll.angular_velocity =  3
		remove_child(spawn)
		add_sibling(ragdoll)
		isgrabbed = false
		
	move_and_slide()
	
func spawn_grab():
	spawn.position = Vector2(0,-150)  
	add_child(spawn)
	isgrabbed = true

