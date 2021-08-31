extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_detect_player_body_entered(body):
	if body.is_in_group("player") or  body.is_in_group("player_2") :
		$AnimationPlayer.play("run")
	
		$AnimationPlayer.play("run")

func _on_detect_player_body_exited(body):
	if body.is_in_group("player") or  body.is_in_group("player_2"):
		$Timer.start()
func _on_Timer_timeout():
	$AnimationPlayer.play("idle")


