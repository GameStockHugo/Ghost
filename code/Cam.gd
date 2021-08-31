extends Camera2D

onready var p1 = get_parent().get_node("YSort/player")
onready var p2 = get_parent().get_node("YSort/player_2")

var zoom_min = 1.8
var zoom_max = 2

func _physics_process(delta):
	position = (p1.position + p2.position) / Vector2(2,2)
	zoom.x = max(zoom_min , abs( (p1.position.x - p2.position.x) /300))
	zoom.y = max(zoom_min , abs( (p1.position.x - p2.position.x) /300))
	
	if zoom.x > zoom_max:
		zoom.y = zoom_max
		zoom.x = zoom_max
