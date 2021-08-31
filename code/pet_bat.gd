extends KinematicBody2D
export (int) var speed = 100

const UP = Vector2(0,-1)
var vel : Vector2

var light = false
var life = 3
var nb_aleat = 3
onready var player = get_parent().get_node("YSort/player")
onready var nav	   = get_parent().get_node("Navigation2D")
onready var player2 = get_parent().get_node("YSort/player_2")

var run =false
var stop = false
func _ready():
	randomize()
	
	nb_aleat = randi()%2
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	_mouvement_loop()
	
	
	
	
	
	
	
func _mouvement_loop():
	
	if nb_aleat ==0:
		
		vel = player2.global_position - self.global_position
		var path:PoolVector2Array = nav.get_simple_path(self.global_position, player2.global_position, true)
		if path.size() !=0:
			vel = path[1] - self.position
		
	if nb_aleat == 1:
		vel = player.global_position - self.global_position
		var path:PoolVector2Array = nav.get_simple_path(self.global_position, player.global_position, true)
		if path.size() !=0:
			vel = path[1] - self.position
	
	
	if vel.x > 0:
		$Sprite.flip_h = false
	if vel.x <0:
		$Sprite.flip_h = true
	if run and !stop:
		move_and_slide(vel.normalized()*speed)
	
	
	



func _on_detect_player_body_entered(body):
	if body.is_in_group("player") :
		nb_aleat = 1
		run = true
		stop = true
		
	if body.is_in_group("player_2") :
		nb_aleat = 0
		run = true
		stop = true


func _on_detect_player_body_exited(body):
	if body.is_in_group("player") :
		
		stop = false
		
	if body.is_in_group("player_2") :
		
		stop = false
