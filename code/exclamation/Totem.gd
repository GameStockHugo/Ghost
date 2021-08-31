extends KinematicBody2D


var life = 30

var light = false
signal mort_totem
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = life
	if light:
		if life >=0:
			life-=0.1
		else:
			SINGLETON.totem_destruct +=1
			print(SINGLETON.totem_destruct)
			queue_free()
func _on_detect_lampe_body_entered(body):
	if body.is_in_group("lum_bleu") or body.is_in_group("lum_rouge"):
		light = true
	

func _on_detect_lampe_body_exited(body):
	if body.is_in_group("lum_bleu") or body.is_in_group("lum_rouge"):
		light = false
