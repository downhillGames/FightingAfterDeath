extends Node2D

# Declare member variables here. Examples:
# var a = 2
var _game_timer = null
var Chest = preload("res://Scenes/Chest.tscn")

var NightStalker = preload("res://Scenes/Characters/NightStalker.tscn")
var Knight = preload("res://Scenes/Characters/Knight.tscn")
var Imp = preload("res://Scenes/Characters/Imp.tscn")
var Reaper = preload("res://Scenes/Characters/Reaper.tscn")
var DarkMoon = preload("res://Scenes/Characters/DarkMoon.tscn")
var MasterKiller = preload("res://Scenes/Characters/MasterKiller.tscn")
var WinterFury = preload("res://Scenes/Characters/WinterFury.tscn")
var SoulMelter = preload("res://Scenes/Characters/SoulMelter.tscn")

export var player_1_X = 0
export var player_1_Y = 0
export var player_2_X = 0
export var player_2_Y = 0
export var player_3_X = 0
export var player_3_Y = 0
export var player_4_X = 0
export var player_4_Y = 0

var game_timer_min
var game_timer_sec
# Called n the node enters the scene tree for the first time.
func _ready():
	_game_timer = Timer.new()
	add_child(_game_timer)
	_game_timer.connect("timeout", self, "_on_Timer_timeout")
	#_game_timer.set_wait_time(300.0)
	_game_timer.set_wait_time(300.0)
	_game_timer.set_one_shot(true) 
	_game_timer.start()
	
	player_one_spawn(player_1_X,player_1_Y)
	player_two_spawn(player_2_X,player_2_Y)

	if (global.mode == 3):
		player_three_spawn(player_3_X,player_3_Y)
		$Control/Player_three_ui.visible = true
	elif (global.mode == 4):
		player_three_spawn(player_3_X,player_3_Y)
		player_four_spawn(player_4_X,player_4_Y)
		$Control/Player_three_ui.visible = true
		$Control/Player_four_ui.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var rand = randInt(1, 500)
	
	game_timer_min =  int (_game_timer.get_time_left()  / 60)
	game_timer_sec =  (_game_timer.get_time_left()  / 60) - game_timer_min
	game_timer_sec *= 60
	game_timer_sec = stepify(game_timer_sec,0.1)
	var time_str =  (String(game_timer_min) + ":" + String(game_timer_sec))
	get_node("Control/time_left_label").set_text("Fight Time: " + time_str)
	
	if (global.mode == 2):
		mode_two_gui()
	elif (global.mode == 3):
		mode_three_gui()
	elif (global.mode == 4):
		mode_four_gui()
	
	if (rand == 10 ):
		print("Created Chest")
		var chestObj  = Chest.instance()
		chestObj.set_position(Vector2(randInt(550, 950),randInt(320, 520)))
		self.add_child(chestObj)
		
		
	pass

func _on_new_Timer_timeout():	
	get_tree().change_scene("res://Scenes/Screens/EndGame.tscn")

func _on_Timer_timeout():

	global.winner = declare_winner()
	var _new_timer = Timer.new()
	add_child(_new_timer)
	_new_timer.connect("timeout", self, "_on_new_Timer_timeout")
	_new_timer.set_wait_time(2.00)
	_new_timer.set_one_shot(true) 
	_new_timer.start()


func declare_winner():
	var characters_array = []
	var scores_array = []
	var player_array = []
	var character_array = []
	var high = 0
	var index
	var player
	var character

	for child in self.get_children():
		if child.has_method("get_health" ):
			characters_array.append(child)
	
	for i in range(0, characters_array.size() - 1):
		for i in range(0, characters_array.size()):
			if (characters_array[i].get_health() > high):
				high = characters_array[i].get_health()
				player = characters_array[i].get_player_num()
				index = i
				character = characters_array[i].get_character_num()
		characters_array.remove(index)
		scores_array.append(high)
		player_array.append(player)
		character_array.append(character)
		high = 0

	character_array.append(characters_array[0].get_character_num())
	scores_array.append(characters_array[0].get_health())
	player_array.append(characters_array[0].get_player_num())
	
	if (scores_array[0] == scores_array[1]):
		return 5
	else:
		global.winner_character = character_array[0]
		return player_array[0]

func player_one_spawn(spawn_x, spawn_y):
	var player
	if (global.player_one_character == 1):
		player  = Imp.instance()
	elif (global.player_one_character == 2):
		player  = Knight.instance()
	elif (global.player_one_character == 3):
		player  = Reaper.instance()
	elif (global.player_one_character == 4):
		player  = NightStalker.instance()
	elif (global.player_one_character == 5):
		player  = DarkMoon.instance()
	elif (global.player_one_character == 6):
		player  = MasterKiller.instance()
	elif (global.player_one_character == 7):
		player  = WinterFury.instance()
	elif (global.player_one_character == 8):
		player  = SoulMelter.instance()
	player.set_player(1)
	player.set_position(Vector2(spawn_x, spawn_y))
	self.add_child(player)


func player_two_spawn(spawn_x, spawn_y):
	var player
	if (global.player_two_character == 1):
		player  = Imp.instance()
	elif (global.player_two_character == 2):
		player  = Knight.instance()
	elif (global.player_two_character == 3):
		player  = Reaper.instance()
	elif (global.player_two_character == 4):
		player  = NightStalker.instance()
	elif (global.player_two_character == 5):
		player  = DarkMoon.instance()
	elif (global.player_two_character == 6):
		player  = MasterKiller.instance()
	elif (global.player_two_character == 7):
		player  = WinterFury.instance()
	elif (global.player_two_character == 8):
		player  = SoulMelter.instance()
	player.set_player(2)
	player.set_position(Vector2(spawn_x, spawn_y))
	self.add_child(player)
	

func mode_four_gui():
	var health_player1
	var health_player2
	var health_player3
	var health_player4
	
	var shield_player1
	var shield_player2
	var shield_player3
	var shield_player4
	
	for child in self.get_children():
		if child.has_method("get_health" ):
			if child.get_player() == "player_one":
				health_player1 =  child.get_health() 
				shield_player1 =  child.get_shield() 
			elif child.get_player() == "player_two":
				health_player2 = child.get_health() 
				shield_player2 =  child.get_shield() 
			elif child.get_player() == "player_three":
				health_player3 = child.get_health() 
				shield_player3 =  child.get_shield() 
			elif child.get_player() == "player_four":
				health_player4 = child.get_health() 
				shield_player4 =  child.get_shield()

	var player_one_health_str
	var player_two_health_str
	var player_three_health_str
	var player_four_health_str
	var player_one_shield_str
	var player_two_shield_str
	var player_three_shield_str
	var player_four_shield_str
	
	if health_player1 != null:
		player_one_health_str = String (health_player1)
		player_one_shield_str = String (shield_player1)
	
	
	if health_player2 != null:
		player_two_health_str = String (health_player2)
		player_two_shield_str = String (shield_player2)
	

	if health_player3 != null:
		player_three_health_str = String (health_player3)
		player_three_shield_str = String (shield_player3)

	if health_player4 != null:
		player_four_health_str = String (health_player4)
		player_four_shield_str = String (shield_player4)
	
	if health_player1 != null:
		get_node("Control/Player_one_ui/player_health").set_text(player_one_health_str + "%")
	
	if shield_player1 != null:
		get_node("Control/Player_one_ui/player_Shield").set_text(player_one_shield_str)
		
	if health_player2 != null:
		get_node("Control/Player_two_ui/player_health").set_text(player_two_health_str + "%")
	
	if shield_player2 != null:
		get_node("Control/Player_two_ui/player_Shield").set_text(player_two_shield_str)
		
	if health_player3 != null:
		get_node("Control/Player_three_ui/player_health").set_text(player_three_health_str + "%")
	
	if shield_player3 != null:
		get_node("Control/Player_three_ui/player_Shield").set_text(player_three_shield_str)
	
	if health_player4 != null:
		get_node("Control/Player_four_ui/player_health").set_text(player_four_health_str + "%")
	
	if shield_player4 != null:
		get_node("Control/Player_four_ui/player_Shield").set_text(player_four_shield_str)


func mode_three_gui():
	var health_player1
	var health_player2
	var health_player3
	
	var shield_player1
	var shield_player2
	var shield_player3
	
	for child in self.get_children():
		if child.has_method("get_health" ):
			if child.get_player() == "player_one":
				health_player1 =  child.get_health() 
				shield_player1 =  child.get_shield() 
			elif child.get_player() == "player_two":
				health_player2 = child.get_health() 
				shield_player2 =  child.get_shield() 
			elif child.get_player() == "player_three":
				health_player3 = child.get_health() 
				shield_player3 =  child.get_shield() 

	var player_one_health_str
	var player_two_health_str
	var player_three_health_str
	var player_one_shield_str
	var player_two_shield_str
	var player_three_shield_str
	
	if health_player1 != null:
		player_one_health_str = String (health_player1)
		player_one_shield_str = String (shield_player1)
	
	
	if health_player2 != null:
		player_two_health_str = String (health_player2)
		player_two_shield_str = String (shield_player2)
	

	if health_player3 != null:
		player_three_health_str = String (health_player3)
		player_three_shield_str = String (shield_player3)
	
	if health_player1 != null:
		get_node("Control/Player_one_ui/player_health").set_text(player_one_health_str + "%")
	
	if shield_player1 != null:
		get_node("Control/Player_one_ui/player_Shield").set_text(player_one_shield_str)
		
	if health_player2 != null:
		get_node("Control/Player_two_ui/player_health").set_text(player_two_health_str + "%")
	
	if shield_player2 != null:
		get_node("Control/Player_two_ui/player_Shield").set_text(player_two_shield_str)
		
	if health_player3 != null:
		get_node("Control/Player_three_ui/player_health").set_text(player_three_health_str + "%")
	
	if shield_player3 != null:
		get_node("Control/Player_three_ui/player_Shield").set_text(player_three_shield_str)


func mode_two_gui():
	var health_player1
	var health_player2
	
	var shield_player1
	var shield_player2
	
	for child in self.get_children():
		if child.has_method("get_health" ):
			if child.get_player() == "player_one":
				health_player1 =  child.get_health() 
				shield_player1 =  child.get_shield() 
			elif child.get_player() == "player_two":
				health_player2 = child.get_health() 
				shield_player2 =  child.get_shield() 

	var player_one_health_str
	var player_two_health_str
	var player_one_shield_str
	var player_two_shield_str
	
	if health_player1 != null:
		player_one_health_str = String (health_player1)
		player_one_shield_str = String (shield_player1)
	
	
	if health_player2 != null:
		player_two_health_str = String (health_player2)
		player_two_shield_str = String (shield_player2)
	
	if health_player1 != null:
		get_node("Control/Player_one_ui/player_health").set_text(player_one_health_str + "%")
	
	if shield_player1 != null:
		get_node("Control/Player_one_ui/player_Shield").set_text(player_one_shield_str)
		
	if health_player2 != null:
		get_node("Control/Player_two_ui/player_health").set_text(player_two_health_str + "%")
	
	if shield_player2 != null:
		get_node("Control/Player_two_ui/player_Shield").set_text(player_two_shield_str)

func player_three_spawn(spawn_x, spawn_y):
	var player
	if (global.player_three_character == 1):
		player  = Imp.instance()
	elif (global.player_three_character == 2):
		player  = Knight.instance()
	elif (global.player_three_character == 3):
		player  = Reaper.instance()
	elif (global.player_three_character == 4):
		player  = NightStalker.instance()
	elif (global.player_three_character == 5):
		player  = DarkMoon.instance()
	elif (global.player_three_character == 6):
		player  = MasterKiller.instance()
	elif (global.player_three_character == 7):
		player  = WinterFury.instance()
	elif (global.player_three_character == 8):
		player  = SoulMelter.instance()
	player.set_player(3)
	player.set_position(Vector2(spawn_x, spawn_y))
	self.add_child(player)

func player_four_spawn(spawn_x, spawn_y):
	var player
	if (global.player_four_character == 1):
		player  = Imp.instance()
	elif (global.player_four_character == 2):
		player  = Knight.instance()
	elif (global.player_four_character == 3):
		player  = Reaper.instance()
	elif (global.player_four_character == 4):
		player  = NightStalker.instance()
	elif (global.player_four_character == 5):
		player  = DarkMoon.instance()
	elif (global.player_four_character == 6):
		player  = MasterKiller.instance()
	elif (global.player_four_character == 7):
		player  = WinterFury.instance()
	elif (global.player_four_character == 8):
		player  = SoulMelter.instance()
	player.set_player(4)
	player.set_position(Vector2(spawn_x, spawn_y))
	self.add_child(player)

func randInt(int_min, int_max):
	randomize()
	return int (rand_range(int_min, int_max+1))

func _on_Music_finished():
	$Music.play()
