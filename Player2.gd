extends CharacterBody2D
@export var move_speed : float = 600.0
@export var jump_force : float = 800.0
@export var gravity : float = 800.0
@export var fall_force : float = 800.0
@export var fast_fall : bool = false
@export var direction = -1
@export var size = 0.2

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta 
	
	if is_on_floor():
		fast_fall = false
		
	velocity.x = 0
	
	if Input.is_action_pressed("P2L"):
		velocity.x -= move_speed
		direction = 1
		get_node( "Sprite2D").scale.x = size  * direction
		#get_node("Hitbox").scale.x = direction
		
	if Input.is_action_pressed("P2R"):
		velocity.x += move_speed
		direction = -1
		get_node("Sprite2D").scale.x = size  * direction
		#get_node("Hitbox").scale.x = direction
	
	if Input.is_action_just_pressed("P2U") and is_on_floor() == true:
			velocity.y = -jump_force
	
	if Input.is_action_just_pressed("P2D") and is_on_floor() == false and fast_fall == false:
		fast_fall = true
		velocity.y = fall_force

	move_and_slide()
