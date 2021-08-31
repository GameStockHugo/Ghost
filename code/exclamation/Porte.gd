extends KinematicBody2D


var totem_destr = 0
var port_open =false
var player = false

var next_room = false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if SINGLETON.totem_destruct == 2 and !port_open:
		
		if player == true:
			$AnimationPlayer.play("open")
			port_open = true
		

	if next_room:
		if SINGLETON.stage == 1:
			get_tree().change_scene("res://scene/world/World_2.tscn")
		if SINGLETON.stage == 2:
			get_tree().change_scene("res://scene/world/World_3.tscn")
		if SINGLETON.stage == 3:
			get_tree().change_scene("res://scene/MainMenu.tscn")

func _on_detect_player_body_entered(body):
	if body.is_in_group("player_2") :
		player = true
	if body.is_in_group("player") :
		
		player = true


func _on_detect_player2_body_entered(body):
	if body.is_in_group("player_2"):
		next_room = true
	if body.is_in_group("player") :
		
		next_room = true
