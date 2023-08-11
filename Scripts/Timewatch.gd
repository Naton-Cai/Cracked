extends Label
var timer
var timelimit = 120
var time = 0
var min = 0
var sec = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_parent().get_node("Timer")
	timer.set_wait_time(timelimit)
	timer.start()	


func _process(delta):
	time = timer.get_time_left()
	min = floor(time/60)
	sec = floor(time-min*60)
	if str(sec).length() == 1:
		self.text = str(min)+str(":0")+str(sec)
	else:
		self.text = str(min)+str(":")+str(sec)
		
