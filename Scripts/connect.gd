extends Node2D


func _ready():
	pass # Replace with function body.

func get_character_num():
	return get_node("Player").character_number

func set_player(player_int):
	if player_int == 1:
		get_node("Player").player1 = true
		get_node("Player").player2 = false
		get_node("Player").player3 = false
		get_node("Player").player4 = false
	elif player_int == 2:
		get_node("Player").player1 = false
		get_node("Player").player2 = true
		get_node("Player").player3 = false
		get_node("Player").player4 = false
	elif player_int == 3:
		get_node("Player").player1 = false
		get_node("Player").player2 = false
		get_node("Player").player3 = true
		get_node("Player").player4 = false
	elif player_int == 4:
		get_node("Player").player1 = false
		get_node("Player").player2 = false
		get_node("Player").player3 = false
		get_node("Player").player4 = true

func get_player_num():
	return get_node("Player").get_player_num()

func get_player():
	return get_node("Player").get_player()

func get_health():
	return get_node("Player").get_health()
	
func get_shield():
	return get_node("Player").get_shield()