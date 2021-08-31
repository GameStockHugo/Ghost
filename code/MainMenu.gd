extends MarginContainer


onready var select_1 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/select_1
onready var select_2 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/select_2
onready var select_3 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/select_3

var current_selection = 0
func _ready():
	set_current_selection(0)
	
	
func _process(delta):
	
	if Input.get_action_strength("bas"):
		current_selection +=0.1
		if current_selection  >=3:
			current_selection = 0
		set_current_selection(current_selection)
	if Input.get_action_strength("haut"):
		current_selection -=0.1
		if current_selection  <= 0:
			current_selection = 3
		set_current_selection(current_selection)
	if Input.is_action_just_pressed("light_1"):
		if current_selection <1:
			get_tree().change_scene("res://scene/world/World.tscn")
		elif current_selection <2:
			pass
		elif current_selection <3:
			get_tree().quit()
func set_current_selection (_current_selection):
	select_1.text = ""
	select_2.text = ""
	select_3.text = ""
	
	if current_selection <=1:
		select_1.text = ">"
	elif current_selection <=2:
		select_2.text = ">"
	elif current_selection <=3:
		select_3.text = ">"
	
