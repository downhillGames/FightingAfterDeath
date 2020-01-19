extends Node2D

var mouse_over_level_1 = false
var mouse_over_level_2 = false
var mouse_over_level_3 = false
var mouse_over_level_4 = false
var mouse_over_level_5 = false
var mouse_over_level_6 = false
var mouse_over_level_7 = false
var mouse_over_level_8 = false
var mouse_over_back = false

func _on_Animation_animation_finished(anim_name):
	if (anim_name == "Start"):
		$Animation.play("Blink")
		$LevelSelection.play()

func _on_GoBackButton_mouse_entered():
	mouse_over_back = true

func _on_GoBackButton_mouse_exited():
	mouse_over_back = false

func _on_GoBackButton_input_event(viewport, event, shape_idx):
	if mouse_over_back and event.is_pressed() and event.button_index == BUTTON_LEFT:
		if (global.mode == 2):
			get_tree().change_scene("res://Scenes/Screens/PlayerTwoSelect.tscn")
		elif (global.mode == 3):
			get_tree().change_scene("res://Scenes/Screens/PlayerThreeSelect.tscn")
		elif (global.mode == 4):
			get_tree().change_scene("res://Scenes/Screens/PlayerFourSelect.tscn")

func _on_Level1_mouse_entered():
	mouse_over_level_1 = true

func _on_Level1_mouse_exited():
	mouse_over_level_1 = false

func _on_Level1_input_event(viewport, event, shape_idx):
	if mouse_over_level_1 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Levels/Level1.tscn")


func _on_Level2_mouse_entered():
	mouse_over_level_2 = true


func _on_Level2_mouse_exited():
	mouse_over_level_2 = false


func _on_Level2_input_event(viewport, event, shape_idx):
	if mouse_over_level_2 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Levels/Level2.tscn")



func _on_Level3_mouse_entered():
	mouse_over_level_3 = true


func _on_Level3_mouse_exited():
	mouse_over_level_3 = false


func _on_Level3_input_event(viewport, event, shape_idx):
	if mouse_over_level_3 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Levels/Level3.tscn")


func _on_Level4_mouse_entered():
	mouse_over_level_4 = true


func _on_Level4_mouse_exited():
	mouse_over_level_4 = false


func _on_Level4_input_event(viewport, event, shape_idx):
	if mouse_over_level_4 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Levels/Level4.tscn")


func _on_Level5_mouse_entered():
	mouse_over_level_5 = true


func _on_Level5_mouse_exited():
	mouse_over_level_5 = false


func _on_Level5_input_event(viewport, event, shape_idx):
	if mouse_over_level_5 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Levels/Level5.tscn")


func _on_Level6_mouse_entered():
	mouse_over_level_6 = true


func _on_Level6_mouse_exited():
	mouse_over_level_6 = false


func _on_Level6_input_event(viewport, event, shape_idx):
	if mouse_over_level_6 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Levels/Level6.tscn")

func _on_Level7_input_event(viewport, event, shape_idx):
	if mouse_over_level_7 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Levels/Level7.tscn")


func _on_Level7_mouse_entered():
	mouse_over_level_7 = true


func _on_Level7_mouse_exited():
	mouse_over_level_7 = false


func _on_Level8_input_event(viewport, event, shape_idx):
	if mouse_over_level_8 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Levels/Level8.tscn")


func _on_Level8_mouse_entered():
	mouse_over_level_8 = true


func _on_Level8_mouse_exited():
	mouse_over_level_8 = false
