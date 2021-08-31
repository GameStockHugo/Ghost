extends KinematicBody2D
var img_dash = preload("res://scene/dash.tscn")
var excla = preload("res://scene/Exclamation.tscn")

#----------------------------------
var light = false
var velocity = Vector2.ZERO
var ACCELERATION = 2000
var MAX_SPEED = 250
var dashing = false
var can_dashing = true
var angle
var pos_coll =Vector2(0,0)
var inverse_x= false
#--------------------
enum{IDLE_FALSE,IDLE_TRUE, WALK_FALSE,WALK_TRUE}
var state = IDLE_FALSE
#---------------------
var nb_de_pas = 0
var can_light = true
var light_compteur = false

var mort = false
signal mort_player_2
func _ready():
	add_to_group("player_2")
	light_compteur = false
	
	nb_de_pas = 1.5
	
	Input.connect("joy_connection_changed",self,"joy_con_changed")
	$bras.add_to_group("lum_rouge")
func joy_con_changed(deviceid,isConnected):

	if isConnected:

		print("Joystick " + str(deviceid) + " connected")

		if Input.is_joy_known(0):

			print("Recognized and compatible joystick")

			print(Input.get_joy_name(0) + " device connected")

		else:

			print("Joystick " + str(deviceid) + " disconnected")
			
func _physics_process(delta):
	
	$ProgressBar.value = nb_de_pas
	_light()
	state_loop()
	
	_mouvement_loop()
	_detect_mur()
	if nb_de_pas >0:
		can_light = true
	else:
		can_light = false
	
func _mouvement_loop():
	var input_vector = Vector2.ZERO
	if Input.is_action_just_pressed("dash_2") and can_dashing:
		can_dashing = false
		dashing = true
		yield(get_tree().create_timer(0.5),'timeout')
		can_dashing = true
	input_vector.x = Input.get_action_strength("droite_2") - Input.get_action_strength("gauche_2")
	input_vector.y = Input.get_action_strength("bas_2") - Input.get_action_strength("haut_2")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION #* delta
		velocity = velocity.clamped(MAX_SPEED)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, 1)
	if mort == false:
		velocity = move_and_slide(velocity)
	angle = atan2(input_vector.y,input_vector.x)
	
	
	if input_vector.x != 0 or input_vector.y != 0 and mort == false:
		$Anim.play("walk")
		
		
		
	else:
		if mort == false:
			$Anim.play("idle")
	
	if !velocity == Vector2.ZERO:
		$bras.rotation = angle
	
	if velocity.x > 0:
		$Sprite.flip_h = false
	if velocity.x <0 :
		$Sprite.flip_h = true
	if dashing:
		
		MAX_SPEED = 1000
		ACCELERATION = 15000
		for x in range (0,3):
			var i = img_dash.instance()
			i.init(position,$Sprite)
			get_parent().add_child(i)
					
			yield(get_tree().create_timer(0.1),'timeout')
			dashing = false
	else:
		
		ACCELERATION = 2000
		MAX_SPEED = 250
	if state == IDLE_FALSE or state == IDLE_TRUE:
		if $Light2D.texture_scale > 1.5:
				$Light2D.texture_scale -=0.008
	if state == WALK_FALSE or state == WALK_TRUE:
		if $Light2D.texture_scale < 2.5:
				$Light2D.texture_scale +=0.02
func state_loop():
	if  (velocity.x != 0 or velocity.y != 0):
		if light == false:
			change_state(WALK_FALSE)
		else:
			change_state(WALK_TRUE)
			
	else:
		if light == false:
			change_state(IDLE_FALSE)
		else:
			change_state(IDLE_TRUE)

func change_state(new_state):
	state = new_state
	match state:
		IDLE_TRUE:
			
			if nb_de_pas > 0:
				nb_de_pas = nb_de_pas - 0.015
				
		IDLE_FALSE:
			pass
			
		WALK_TRUE:
			
			if nb_de_pas > 0:
				nb_de_pas = nb_de_pas - 0.015
			else:
				_excla_player()
				light = false
				
		WALK_FALSE:
			if nb_de_pas < 3:
				nb_de_pas = nb_de_pas + 0.01
				
			
		
		

func _light():
	if Input.is_action_just_pressed("light_2"):
		if light:
			light = false
		else:
			light = true
	
	
	if light:
		if can_light:
			$bras/Light2D.enabled = true
			$bras/CollisionPolygon2D.disabled = false
		else:
			$bras/Light2D.enabled = false
			$bras/CollisionPolygon2D.disabled = true
	else:
		
		$bras/Light2D.enabled = false
		$bras/CollisionPolygon2D.disabled = true	
		
	
func _flash_ligh():
	pass
func _detect_mur():
	var pos = $bras/detec_mur.get_collision_point()
	pos_coll= pos - $bras/detec_mur.position
	if $bras/detec_mur.is_colliding() == true:
		var pos_coll = pos - self.position
		if self.position.x < pos.x:
			
			$bras/CollisionPolygon2D.polygon[0] = Vector2(pos_coll.x  ,-50) 
			$bras/CollisionPolygon2D.polygon[3] = Vector2(pos_coll.x ,50) 
		if self.position.x > pos.x:
			$bras/CollisionPolygon2D.polygon[0] = Vector2(-pos_coll.x  ,-50) 
			$bras/CollisionPolygon2D.polygon[3] = Vector2(-pos_coll.x ,50) 
		if self.position.y <pos.y:
			$bras/CollisionPolygon2D.polygon[0] = Vector2(pos_coll.y ,-50) 
			$bras/CollisionPolygon2D.polygon[3] = Vector2(pos_coll.y,50) 
		if self.position.y >pos.y:
			$bras/CollisionPolygon2D.polygon[0] = Vector2(-pos_coll.y ,-50) 
			$bras/CollisionPolygon2D.polygon[3] = Vector2(-pos_coll.y,50) 
	else:
		$bras/CollisionPolygon2D.polygon[0] = Vector2(400,-56)
		$bras/CollisionPolygon2D.polygon[3] = Vector2(400,56)
		
		
func _excla_player():
	var i = excla.instance()
	i.position = Vector2(-15,-90)
	add_child(i)
	
	
func _on_Detect_enemie_body_entered(body):
	if body.is_in_group("Fantome") :
		if !mort:
			mort = true
			$Anim.play("mort")
		#yield($Anim,"animation_finished")
			emit_signal("mort_player_2")
