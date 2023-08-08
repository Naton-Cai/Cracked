extends Node2D
var player2 = preload("res://Player2.tscn")
var player1 = preload("res://Player1.tscn")
var player1HP = 30
var player2HP = 30
var player1STAMINA = 700.0
var player2STAMINA = 700.0
var player1Points = 0
var player2Points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnP1(Vector2(460, 200))
	spawnP2(Vector2(1460, 200))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass
	
	
#calculates damage for player 1
func P1Damage(damage):
	player1HP -= damage
	return player1HP

#calculates damage for player 2
func P2Damage(damage):
	player2HP -= damage
	return player2HP

func respawnP1():
	player1HP = 20
	spawnP1(Vector2(460, 200))
	player1STAMINA = 700.0

func respawnP2():
	player2HP = 20
	spawnP2(Vector2(1460, 200))
	player2STAMINA = 700.0

#spawns player 1 into position
func spawnP1(position):
	var player_1 = player1.instantiate()
	player_1.position = position  
	player_1.set_physics_process(true)
	self.add_child(player_1)
	
#spawns player 2 into position
func spawnP2(position):
	var player_2 = player2.instantiate()
	player_2.position = position  
	player_2.set_physics_process(true)
	self.add_child(player_2)
	
func addpointsP1(points):
	player1Points += points
	
func addpointsP2(points):
	player2Points += points
	


