extends Node2D


var mouse_over_menu = false
var mouse_over_prev = false
var mouse_over_next = false

func _on_MenuButton_input_event(viewport, event, shape_idx):
	if mouse_over_menu and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")


func _on_MenuButton_mouse_entered():
	 mouse_over_menu = true


func _on_MenuButton_mouse_exited():
	 mouse_over_menu = false


func _on_NextArrow_input_event(viewport, event, shape_idx):
	if mouse_over_next and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Screens/Help2.tscn")


func _on_NextArrow_mouse_entered():
	 mouse_over_next = true


func _on_NextArrow_mouse_exited():
	 mouse_over_next = false


func _on_BackArrow_input_event(viewport, event, shape_idx):
	if mouse_over_prev and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Screens/Help2.tscn")


func _on_BackArrow_mouse_entered():
	 mouse_over_prev = true


func _on_BackArrow_mouse_exited():
	 mouse_over_prev = false
