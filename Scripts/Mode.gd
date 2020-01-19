extends Node2D

var mouse_over_two = false
var mouse_over_three = false
var mouse_over_four = false
var mouse_over_back = false


func _ready():
	pass # Replace with function body.


func go_to_scene():
	get_tree().change_scene("res://Scenes/Screens/PlayerOneSelect.tscn")

func _on_Animation_animation_finished(anim_name):
	if (anim_name == "Intro"):
		$Animation.play("Blink")
		$Mode.play()

func _on_GoBackButton_mouse_entered():
	mouse_over_back = true


func _on_GoBackButton_mouse_exited():
		mouse_over_back = false


func _on_GoBackButton_input_event(viewport, event, shape_idx):
	if mouse_over_back and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")


func _on_2Players_mouse_entered():
	mouse_over_two = true


func _on_2Players_mouse_exited():
	mouse_over_two = false


func _on_2Players_input_event(viewport, event, shape_idx):
	if mouse_over_two and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.mode = 2
		go_to_scene()


func _on_3Players_mouse_entered():
	mouse_over_three = true


func _on_3Players_mouse_exited():
	mouse_over_three = false


func _on_3Players_input_event(viewport, event, shape_idx):
	if mouse_over_three and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.mode = 3
		go_to_scene()


func _on_4Players_mouse_entered():
	mouse_over_four = true


func _on_4Players_mouse_exited():
	mouse_over_four = false


func _on_4Players_input_event(viewport, event, shape_idx):
	if mouse_over_four and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.mode = 4
		go_to_scene()
