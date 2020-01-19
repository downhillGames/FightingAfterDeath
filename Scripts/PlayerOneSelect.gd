extends Node2D

var mouse_over_fighter_1 = false
var mouse_over_fighter_2 = false
var mouse_over_fighter_3 = false
var mouse_over_fighter_4 = false
var mouse_over_fighter_5 = false
var mouse_over_fighter_6 = false
var mouse_over_fighter_7 = false
var mouse_over_fighter_8 = false
var mouse_over_back = false

func go_to_scene():
	get_tree().change_scene("res://Scenes/Screens/PlayerTwoSelect.tscn")
	
func _on_Fighter1_mouse_entered():
	mouse_over_fighter_1 = true


func _on_Fighter1_mouse_exited():
	mouse_over_fighter_1 = false


func _on_Fighter1_input_event(viewport, event, shape_idx):
	if mouse_over_fighter_1 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.player_one_character = 1
		go_to_scene()


func _on_Fighter2_mouse_entered():
	mouse_over_fighter_2 = true


func _on_Fighter2_mouse_exited():
	mouse_over_fighter_2 = false


func _on_Fighter2_input_event(viewport, event, shape_idx):
	if mouse_over_fighter_2 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.player_one_character = 2
		go_to_scene()


func _on_Fighter3_input_event(viewport, event, shape_idx):
	if mouse_over_fighter_3 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.player_one_character = 3
		go_to_scene()


func _on_Fighter3_mouse_entered():
	mouse_over_fighter_3 = true


func _on_Fighter3_mouse_exited():
	mouse_over_fighter_3 = false


func _on_Fighter4_input_event(viewport, event, shape_idx):
	if mouse_over_fighter_4 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.player_one_character = 4
		go_to_scene()


func _on_Fighter4_mouse_entered():
	mouse_over_fighter_4 = true


func _on_Fighter4_mouse_exited():
	mouse_over_fighter_4 = false


func _on_Animation_animation_finished(anim_name):
	if (anim_name == "Intro"):
		$Animation.play("Blink")
		$PlayerSelection.play()


func _on_GoBackButton_input_event(viewport, event, shape_idx):
	if mouse_over_back and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Screens/Mode.tscn")


func _on_GoBackButton_mouse_entered():
	mouse_over_back = true


func _on_GoBackButton_mouse_exited():
	mouse_over_back = false


func _on_Fighter5_input_event(viewport, event, shape_idx):
	if mouse_over_fighter_5 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.player_one_character = 5
		go_to_scene()


func _on_Fighter5_mouse_entered():
	mouse_over_fighter_5 = true


func _on_Fighter5_mouse_exited():
	mouse_over_fighter_5 = false


func _on_Fighter6_input_event(viewport, event, shape_idx):
	if mouse_over_fighter_6 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.player_one_character = 6
		go_to_scene()


func _on_Fighter6_mouse_entered():
	mouse_over_fighter_6 = true


func _on_Fighter6_mouse_exited():
	mouse_over_fighter_6 = false


func _on_Fighter7_input_event(viewport, event, shape_idx):
	if mouse_over_fighter_7 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.player_one_character = 7
		go_to_scene()


func _on_Fighter7_mouse_entered():
	mouse_over_fighter_7 = true


func _on_Fighter7_mouse_exited():
	mouse_over_fighter_7 = false


func _on_Fighter8_input_event(viewport, event, shape_idx):
	if mouse_over_fighter_8 and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.player_one_character = 8
		go_to_scene()


func _on_Fighter8_mouse_entered():
	mouse_over_fighter_8 = true


func _on_Fighter8_mouse_exited():
	mouse_over_fighter_8 = false
