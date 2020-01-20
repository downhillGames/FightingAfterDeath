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

	if (global.winner_character == 1):
		$"Node2D/Fighter1".visible = true
		$"Node2D/Control/Imp".visible = true
	elif (global.winner_character == 2):
		$"Node2D/Fighter2".visible = true
		$"Node2D/Control/Knight".visible = true
	elif (global.winner_character == 3):
		$"Node2D/Fighter3".visible = true
		$"Node2D/Control/Reaper".visible = true
	elif (global.winner_character == 4):
		$"Node2D/Fighter4".visible = true
		$"Node2D/Control/Night Stalker".visible = true
	elif (global.winner_character == 5):
		$"Node2D/Fighter5".visible = true
		$"Node2D/Control/Dark Moon".visible = true
	elif (global.winner_character == 6):
		$"Node2D/Fighter6".visible = true
		$"Node2D/Control/Dark Moon".visible = true
	elif (global.winner_character == 7):
		$"Node2D/Fighter7".visible = true
		$"Node2D/Control/Winter Fury".visible = true
	elif (global.winner_character == 8):
		$"Node2D/Fighter8".visible = true
		$"Node2D/Control/Soul Melter".visible = true
		
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
		$Node2D/Animation.play("Blink")
	
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