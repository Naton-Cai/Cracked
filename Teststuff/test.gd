extends Node2D
var player2 = preload("res://player_2.tscn")
var player1 = preload("res://player_1.tscn")
var player1HP = 20
var player2HP = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_2 = player2.instantiate()
	var player_1 = player1.instantiate()
	player_2.set_physics_process(true)
	player_1.set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	
func P1Damage(damage):
	print(damage)
	player1HP -= damage
	return player1HP

func P2Damage(damage):
	print(damage)
	player2HP -= damage
	return player2HP
	
func spawnP1(position):
	var player_1 = player1.instantiate()
	player_1.position = position  
	player_1.set_physics_process(true)
	self.add_child(player_1)	

func spawnP2(position):
	var player_2 = player2.instantiate()
	player_2.position = position  
	player_2.set_physics_process(true)
	self.add_child(player_2)
