extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if(get_tree().paused):
		$TutorialScreen.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.

