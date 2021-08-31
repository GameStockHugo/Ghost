extends Node2D
onready var fantome_bleu = preload("res://scene/Fantome_bleu.tscn")
onready var fantome_rouge = preload("res://scene/Fantome_rouge.tscn")
onready var Totem =preload("res://scene/acc/Totem.tscn")
var speak_bleu = true
var speak_red = false

var speak_intro = false
var speak_destru_tombe = false

var spaw_change = true
var gameover = false
var can_anim_gameover = true
var stage_numb = 2

onready var Tile = $TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	SINGLETON.stage = 2
	randomize()
	$CanvasLayer/Totem.visible = false
	speak_intro = true
	SINGLETON.totem_destruct = 1
	$CanvasLayer/Stage_affich.text = "Stage " +str( stage_numb) +"..."
	$CanvasLayer/Stage_affich.percent_visible = 0
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $CanvasLayer/Stage_affich.percent_visible <=1:
		$CanvasLayer/Stage_affich.percent_visible +=0.01
	if $CanvasLayer/Stage_affich.percent_visible ==1:
		$CanvasLayer/Stage_affich.visible = false
		
	if gameover:
		_gameover()
	if speak_intro:
		_dialogue_intro()
	if speak_destru_tombe:
		_dialogue_dest_tombe()
	if SINGLETON.totem_destruct == 2:
		_dialogue_fin()
	$CanvasLayer/Totem/Label.text = str(SINGLETON.totem_destruct) +   " / 2"
func _dialogue_intro():
	if speak_bleu == true:
		$CanvasLayer/Panel.visible = true
		$CanvasLayer/Panel/Label.percent_visible += 0.005
		$CanvasLayer/Panel/Sprite.texture =  preload("res://image/player/player_2.png")
		$CanvasLayer/Panel/Label.text = "Ce lieux me dit vaguement quelque chose!!!  "
		if $CanvasLayer/Panel/Label.percent_visible == 1:
			$CanvasLayer/Panel/Label.percent_visible = 0
			$CanvasLayer/Panel.visible = false
			speak_bleu = false
	
		
func _dialogue_dest_tombe():
	if speak_bleu == true:
		$CanvasLayer/Panel.visible = true
		$CanvasLayer/Panel/Label.percent_visible += 0.008
		$CanvasLayer/Panel/Sprite.texture =  preload("res://image/player/player_2.png")
		$CanvasLayer/Panel/Label.text = "Et voila, une bonne chose de faite, maintenant on se casse!!  "
		if $CanvasLayer/Panel/Label.percent_visible == 1:
			$CanvasLayer/Panel/Label.percent_visible = 0
			
			speak_bleu = false
	if speak_bleu == false:
		$CanvasLayer/Panel/Label.percent_visible += 0.008
		$CanvasLayer/Panel/Sprite.texture =  preload("res://image/player/player.png")
		$CanvasLayer/Panel/Label.text = "Il faut trouver un moyen de sortir!!! "
		if $CanvasLayer/Panel/Label.percent_visible == 1:
			$CanvasLayer/Panel.visible = false
			$CanvasLayer/Panel/Label.percent_visible = 0
			speak_destru_tombe = false
func _dialogue_fin():
	$CanvasLayer/Panel.visible = true
	$CanvasLayer/Panel/Label.percent_visible += 0.005
	$CanvasLayer/Panel/Sprite.texture =  preload("res://image/player/player.png")
	$CanvasLayer/Panel/Label.text = "Bravo, La porte est desormée ouverte!!"
	if $CanvasLayer/Panel/Label.percent_visible == 1:
		$CanvasLayer/Panel.visible = false
		#$CanvasLayer/Panel/Label.percent_visible = 0
func _on_Tombe_mort():
	$CanvasLayer/Totem.visible = true
	speak_bleu = true
	speak_destru_tombe = true
	
	var totem = Totem.instance()
	totem.position = Vector2(2632,1504)
	add_child(totem)
	var totem2 = Totem.instance()
	totem2.position =Vector2(1352,560)
	add_child(totem2)
func _gameover():
	if can_anim_gameover:
		$CanvasLayer/AnimationPlayer.play("gameover")
		yield($CanvasLayer/AnimationPlayer,"animation_finished")
		can_anim_gameover = false
	if Input.is_action_pressed("light_1"):
		get_tree().change_scene("res://scene/world/World_2.tscn")
		SINGLETON.totem_destruct = 0
	if Input.is_action_pressed("dash"):
		get_tree().change_scene("res://scene/MainMenu.tscn")
		SINGLETON.totem_destruct = 0
func _on_player_mort_player():
	gameover = true


func _on_player_2_mort_player_2():
	gameover = true
func _spawn():
	
	if spaw_change:
		var eb = fantome_bleu.instance()
		eb.position = $spawn_gosh/Position2D.position
		add_child(eb)
		var er = fantome_rouge.instance()
		er.position =$spawn_gosh/Position2D2.position
		add_child(er)
		spaw_change = false
	else:
		var eb = fantome_bleu.instance()
		eb.position = $spawn_gosh/Position2D2.position
		add_child(eb)
		var er = fantome_rouge.instance()
		er.position =$spawn_gosh/Position2D.position
		add_child(er)
		spaw_change = true

func _on_Timer_timeout():
	_spawn()


func _on_spawn_fantomme_body_entered(body):
	
	if body.is_in_group("player_2") or body.is_in_group("player"):
		var nb_aleat = randi()%2
		print(nb_aleat)
		if nb_aleat == 0:
			var eb = fantome_bleu.instance()
			eb.position = $spawn_gosh/spawn.position
			add_child(eb)
			$spawn_fantomme.queue_free()
		if nb_aleat ==1:
			var er = fantome_rouge.instance()
			er.position = $spawn_gosh/spawn.position
			add_child(er)	
		
			$spawn_fantomme.queue_free()



