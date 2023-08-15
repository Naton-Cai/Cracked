extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("I have been called")
	$TutorialAnimation.play("Button Press")


