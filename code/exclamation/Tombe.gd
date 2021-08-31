extends KinematicBody2D


var life = 50

var light = false
signal mort
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = life
	if light:
		if life >=0:
			life-=0.1
		else:
			emit_signal("mort")
			queue_free()
func _on_detect_lampe_body_entered(body):
	if body.is_in_group("lum_bleu") or body.is_in_group("lum_rouge"):
		light = true
	

func _on_detect_lampe_body_exited(body):
	if body.is_in_group("lum_bleu") or body.is_in_group("lum_rouge"):
		light = false
