extends Node2D

var mouse_over_menu = false
var mouse_over_quit = false



func _ready():
	
	if global.winner == 1:
		get_node("player_one_won").visible = true
	elif global.winner == 2:
		get_node("player_two_won").visible = true
	elif global.winner == 3:
		get_node("player_three_won").visible = true
	elif global.winner == 4:
		get_node("player_four_won").visible = true
	else:
		get_node("game_draw").visible = true



func _on_QuitButton_mouse_entered():
	mouse_over_quit = true

func _on_QuitButton_mouse_exited():
	mouse_over_quit = false


func _on_QuitButton_input_event(viewport, event, shape_idx):
	if mouse_over_quit and event.is_pressed() and event.button_index == BUTTON_LEFT:
		get_tree().quit()


func _on_MenuButton_mouse_entered():
	mouse_over_menu = true


func _on_MenuButton_mouse_exited():
	mouse_over_menu = false


func _on_MenuButton_input_event(viewport, event, shape_idx):
	if mouse_over_menu and event.is_pressed() and event.button_index == BUTTON_LEFT:
		global.reset()
		get_tree().change_scene("res://Scenes/Screens/MainMenu.tscn")


func _on_Animation_animation_finished(anim_name):
	if (anim_name == "Intro"):
		$Animation.play("Blink")
	
		if global.winner == 1:
			$Player1Wins.play()
		elif global.winner == 2:
			$Player2Wins.play()
		elif global.winner == 3:
			$Player3Wins.play()
		elif global.winner == 4:
			$Player4Wins.play()
		else:
			$NoWinner.play()