extends Node2D
onready var fantome_bleu = preload("res://scene/Fantome_bleu.tscn")
onready var fantome_rouge = preload("res://scene/Fantome_rouge.tscn")
onready var Totem =preload("res://scene/acc/Totem.tscn")
var speak_bleu = true
var speak_red = false

var speak_intro = false
var speak_destru_tombe = false

var can_anim_gameover = true
var gameover = false

onready var Tile = $TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	SINGLETON.ghost_dead = 0
	SINGLETON.totem_destruct = 2
	SINGLETON.stage = 3
	
	speak_intro = true
	
	
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

	
	
	$CanvasLayer/Ghost_kill/Label.text = str(SINGLETON.ghost_dead)
func _dialogue_intro():
	if speak_bleu == true:
		$CanvasLayer/Panel.visible = true
		$CanvasLayer/Panel/Label.percent_visible += 0.005
		$CanvasLayer/Panel/Sprite.texture =  preload("res://image/player/player_2.png")
		$CanvasLayer/Panel/Label.text = "J'entends le cri d'un animal en détresse!!.."
		if $CanvasLayer/Panel/Label.percent_visible == 1:
			$CanvasLayer/Panel/Label.percent_visible = 0
			
			speak_bleu = false
	else:
		$CanvasLayer/Panel/Label.percent_visible += 0.005
		$CanvasLayer/Panel/Sprite.texture =  preload("res://image/player/player.png")
		$CanvasLayer/Panel/Label.text = "Il faut le trouver!!"
		if $CanvasLayer/Panel/Label.percent_visible == 1:
			$CanvasLayer/Panel.visible = false
			$CanvasLayer/Panel/Label.percent_visible = 0
			speak_intro = false
		

func _gameover():
	if can_anim_gameover:
		$CanvasLayer/AnimationPlayer.play("gameover")
		yield($CanvasLayer/AnimationPlayer,"animation_finished")
		can_anim_gameover = false
	if Input.is_action_pressed("light_1"):
		get_tree().change_scene("res://scene/world/World_Survival.tscn")
		SINGLETON.totem_destruct = 0
	if Input.is_action_pressed("dash"):
		get_tree().change_scene("res://scene/MainMenu.tscn")
		SINGLETON.totem_destruct = 0
func _on_player_mort_player():
	gameover = true


func _on_player_2_mort_player_2():
	gameover = true
func _spawn():
	var eb = fantome_bleu.instance()
	eb.position = $spawn_gosh/Position2D.position
	add_child(eb)
	var er = fantome_rouge.instance()
	er.position =$spawn_gosh/Position2D2.position
	add_child(er)
	
	

func _on_Timer_timeout():
	_spawn()
