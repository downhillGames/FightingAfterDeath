extends Node2D


var mouse_over_fight = false
var mouse_over_quit = false




func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Intro"):
		$Animation.play("Blink")


func _on_FightButton_mouse_entered():
	mouse_over_fight = true


func _on_FightButton_mouse_exited():
	mouse_over_fight = false


func _on_FightButton_input_event(viewport, event, shape_idx):
	if mouse_over_fight and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Scenes/Screens/Mode.tscn")




func _on_QuitButton_mouse_entered():
	mouse_over_quit = true


func _on_QuitButton_mouse_exited():
	mouse_over_quit = false


func _on_QuitButton_input_event(viewport, event, shape_idx):
	if mouse_over_quit and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().quit()