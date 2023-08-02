extends CharacterBody2D

@export var move_speed : float = 600.0
@export var jump_force : float = 500.0
@export var gravity : float = 800.0
@export var fall_force : float = 800.0
@export var fast_fall : bool = false
var p_1 = preload("res://p_1.tscn")
var p_1_ragdoll = preload("res://p_1_ragdoll.tscn")
var spawn = p_1.instantiate() 
var isgrabbed = false
var direction = 1
var size = 0.27

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		fast_fall = false
		
	velocity.x = 0
	
	if Input.is_action_pressed("P2L"):
		velocity.x -= move_speed
		direction = -1
		get_node( "Sprite" ).scale.x = size  * direction
		get_node("Hitbox").scale.x = direction
		
	if Input.is_action_pressed("P2R"):
		velocity.x += move_speed
		direction = 1
		get_node( "Sprite" ).scale.x = size  * direction
		get_node("Hitbox").scale.x = direction
	
	if Input.is_action_just_pressed("P2U") and is_on_floor() == true:
			velocity.y = -jump_force
	
	if Input.is_action_just_pressed("P2D") and is_on_floor() == false and fast_fall == false:
		fast_fall = true
		velocity.y = fall_force
		
	if Input.is_action_just_pressed("SPAWN2") and isgrabbed == false:
		$AnimationPlayer.play("Player 1 Grab")
	
	if  Input.is_action_just_pressed("THROW2") and isgrabbed == true:
		var ragdoll = p_1_ragdoll.instantiate() as RigidBody2D
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
