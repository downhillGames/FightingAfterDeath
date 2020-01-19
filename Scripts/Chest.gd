extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var opened = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !opened:
		$Animation.play("Flash")
	

func randItem():
	opened = true
	$Animation.play("Open")

func randInt(int_min, int_max):
	randomize()
	return int (rand_range(int_min, int_max+1))

func _on_Area2D_body_entered(body):
	if (body.name == "Player" && !opened):
		opened = true
		$Grabbed.play()
		$Animation.play("Open")
		
		var rand = randInt(1,7)
		
		if (rand == 7):
			body.power_up_heart()
		elif (rand == 6):
			body.power_up_lightning()
		elif (rand == 5):
			body.power_up_double_damage()
		elif (rand == 4):
			body.power_up_fireball()
		elif (rand == 3):
			body.power_up_invincible()
		elif (rand == 2):
			body.power_up_second_chance()
		else:
			body.power_up_second_chance()



func _on_Animation_animation_finished(anim_name):
	if anim_name == "Open":
		get_parent().queue_free()
	pass # Replace with function body.
	
	



func _on_Area2D_area_entered(area):
	if (area.name == "PlayerArea" && !opened):
		opened = true
		$Grabbed.play()
		$Animation.play("Open")
		
		var rand = randInt(1,7)
		
		if (rand == 7):
			area.get_parent().power_up_lightning()
		elif (rand == 6):
			area.get_parent().power_up_lightning()
		elif (rand == 5):
			area.get_parent().power_up_double_damage()
		elif (rand == 4):
			area.get_parent().power_up_fireball()
		elif (rand == 3):
			area.get_parent().power_up_invincible()
		elif (rand == 2):
			area.get_parent().power_up_second_chance()
		else:
			area.get_parent().power_up_second_chance()
