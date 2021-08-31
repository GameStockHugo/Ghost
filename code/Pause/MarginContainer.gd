extends MarginContainer

onready var select_1 = $Pause/Control/MarginContainer/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/select_1
onready var select_2 = $Pause/Control/MarginContainer/CenterContainer/VBoxContainer/CenterContainer3/VBoxContainer/CenterContainer/HBoxContainer/select_2

var current_selection = 0

func _ready():
	set_current_selection(0)
	
	
func _process(delta):

		if Input.get_action_strength("bas"):
			current_selection +=0.1
			if current_selection  >=2:
				current_selection = 0
			set_current_selection(current_selection)
		if Input.get_action_strength("haut"):
			current_selection -=0.1
			if current_selection  <= 0:
				current_selection = 0
			set_current_selection(current_selection)
		if Input.is_action_just_pressed("light_1"):
			if current_selection <1:
				get_tree().change_scene("res://scene/world/World.tscn")
			elif current_selection <2:
				pass
		
func set_current_selection (_current_selection):
	select_1.text = ""
	select_2.text = ""

	
	if current_selection <1:
		select_1.text = ">"
	elif current_selection <2:
		select_2.text = ">"
	
	

