extends KinematicBody2D

var Sparkle = preload("res://Scenes/PowerUps/Sparkle.tscn")
var Fireball = preload("res://Scenes/PowerUps/Fireball.tscn")
var Heart = preload("res://Scenes/PowerUps/Heart.tscn")

var Lightning = preload("res://Scenes/PowerUps/Lightning.tscn")

var lightning_powered = false


const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 35
const MAX_SPEED = 150
const JUMP_HEIGHT = -400


var damge_multi = 1
var _fireball_timer = null
var _flash_timer = null
var _double_damage_timer = null

var fireball_timer = 0
var attack_sound_timer = 0
var hurt_timer = 0
var double_damage_timer = 0

var invincible = false

var dead = false
export var exposed = true

var player_control = true
export var player1 = false
export var player2 = false
export var player3 = false
export var player4 = false

export var character_number = 0

export var shield_recharge = 0
export var attacking = false
var motion = Vector2()
var health = 100
var attack_timer = 0
var damageStrength = 10
var friction = false
# Called when the node enters the scene tree for the first time.
func _ready():
	_fireball_timer = Timer.new()
	add_child(_fireball_timer)
	_fireball_timer.connect("timeout", self, "_on_Timer_timeout")
	_fireball_timer.set_wait_time(1.0)
	_fireball_timer.set_one_shot(false) # Make sure it loops
	_fireball_timer.start()

		
	_double_damage_timer = Timer.new()
	add_child(_double_damage_timer)
	_double_damage_timer.connect("timeout", self, "_on_Double_Timer_timeout")
	_double_damage_timer.set_wait_time(0.2)
	_double_damage_timer.set_one_shot(false) # Make sure it loops
	_double_damage_timer.start()
	
	pass # Replace with function body.


func die():
	$Animation.play("Die")
	player_control = false

func get_health():
	return health

func get_shield():
	return shield_recharge

func get_player_num():
	if (player1 == true ):
		return 1
	elif (player2 == true ):
		return 2
	elif (player3 == true ):
		return 3
	elif (player4 == true ):
		return 4

func get_player():
	if (player1 == true ):
		return "player_one"
	elif (player2 == true ):
		return "player_two"
	elif (player3 == true ):
		return "player_three"
	elif (player4 == true ):
		return "player_four"

func takeDamage(damageAmt):
	if !dead:
		health -= damageAmt
		print (health)
		if health <= 0:
			dead = true
			die()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	motion.y += GRAVITY
	
	if (hurt_timer > 0):
		hurt_timer -=1
	
	if (shield_recharge > 0):
		shield_recharge -=1
	
	if (attack_sound_timer > 0):
		attack_sound_timer -=1

	if (attack_timer > 0):
		attack_timer -=1

	if (character_number == 8):
		if ($Sprite.flip_h):
			$Sprite.offset = Vector2(-18 ,0)
		else: 
			$Sprite.offset = Vector2(0 ,0)
			
	
	if (player_control):
		movement()


	motion = move_and_slide(motion, UP)
	for i in range(get_slide_count() - 1):
       var collision = get_slide_collision(i)

       if (collision.collider.name == "Player"):
	         if attacking == true && collision.collider.exposed == true &&  collision.collider.invincible == false && attack_timer == 0:
		          collision.collider.takeDamage(damageStrength * damge_multi)
		          collision.collider.flash()
		          collision.collider.playHurt()
		          attack_timer = 60
		          if ($Sprite.flip_h == true):
			           collision.collider.fall_left()
		          else:
			           collision.collider.fall_right()
 


func fall_right():
	motion.x = min(motion.x+100, MAX_SPEED)

func fall_left():
	motion.x = max(motion.x-100, -MAX_SPEED)

func movement():
	if (player1):
		if Input.is_action_pressed("player_one_attack_1"):
			if (!dead):
				playAttack()
				if( character_number == 1  || character_number == 2):
					damageStrength = 15
				else:
					damageStrength = 15
				if ($Sprite.flip_h == true):
					$Animation.play("Attack_1_left")
				else:
					$Animation.play("Attack_1")
		elif Input.is_action_pressed("player_one_attack_2"):
			if (!dead):
				playAttack()
				if (lightning_powered):
					shoot_lightning()
					lightning_powered = false
				else:
					if( character_number == 1  || character_number == 2):
						damageStrength = 20
					else:
						damageStrength = 15
					if ($Sprite.flip_h == true):
						$Animation.play("Attack_2_left")
					else:
						$Animation.play("Attack_2")
		elif Input.is_action_pressed("player_one_shield"):
			if (!dead && shield_recharge == 0):
				$Animation.play("Shield")
		elif Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$CollisionPolygon2D.scale.x = 1
			$Animation.play("Run")
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$CollisionPolygon2D.scale.x = -1
			$Animation.play("Run")
		else:
			$Animation.play("Idle")
			attacking = false
			friction = true

		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if motion.y < 0:
				$Animation.play("Jump")
			else:
				#$Sprite.play("Fall")
				pass
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)

	if (player2):
		if Input.is_action_pressed("player_two_attack_1"):
			if (!dead):
				playAttack()
				if(character_number == 5):
					damageStrength = 10
				else:
					damageStrength = 15
				if ($Sprite.flip_h == true):
					$Animation.play("Attack_1_left")
				else:
					$Animation.play("Attack_1")
		elif Input.is_action_pressed("player_two_attack_2"):
			if (!dead):
				playAttack()
				if (lightning_powered):
					shoot_lightning()
					lightning_powered = false
				else:
					if( character_number == 5):
						damageStrength = 15
					else:
						damageStrength = 20
					if ($Sprite.flip_h == true):
						$Animation.play("Attack_2_left")
					else:
						$Animation.play("Attack_2")
		elif Input.is_action_pressed("player_two_shield"):
			if (!dead && shield_recharge == 0):
				$Animation.play("Shield")
		elif Input.is_key_pressed(KEY_D):
			motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$CollisionPolygon2D.scale.x = 1
			$Animation.play("Run")
		elif Input.is_key_pressed(KEY_A):
			motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$CollisionPolygon2D.scale.x = -1
			$Animation.play("Run")
		else:
			$Animation.play("Idle")
			attacking = false
			friction = true

		if is_on_floor():
			if Input.is_action_just_pressed("player_two_jump"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if motion.y < 0:
				$Animation.play("Jump")
			else:
				#$Sprite.play("Fall")
				pass

	if (player4):
		if Input.is_action_pressed("player_four_attack_1"):
			if (!dead):
				playAttack()
				if(character_number == 5):
					damageStrength = 10
				else:
					damageStrength = 15
				if ($Sprite.flip_h == true):
					$Animation.play("Attack_1_left")
				else:
					$Animation.play("Attack_1")
		elif Input.is_action_pressed("player_four_attack_2"):
			if (!dead):
				playAttack()
				if (lightning_powered):
					shoot_lightning()
					lightning_powered = false
				else:
					if( character_number == 5):
						damageStrength = 15
					else:
						damageStrength = 20
					if ($Sprite.flip_h == true):
						$Animation.play("Attack_2_left")
					else:
						$Animation.play("Attack_2")
		elif Input.is_action_pressed("player_four_shield"):
			if (!dead && shield_recharge == 0):
				$Animation.play("Shield")
		elif Input.is_action_pressed("player_four_right"):
			motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$CollisionPolygon2D.scale.x = 1
			$Animation.play("Run")
		elif Input.is_action_pressed("player_four_left"):
			motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$CollisionPolygon2D.scale.x = -1
			$Animation.play("Run")
		else:
			$Animation.play("Idle")
			attacking = false
			friction = true

		if is_on_floor():
			if Input.is_action_just_pressed("player_four_jump"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if motion.y < 0:
				$Animation.play("Jump")
			else:
				#$Sprite.play("Fall")
				pass

	if (player3):
		if Input.is_action_pressed("player_three_attack_1"):
			if (!dead):
				playAttack()
				if(character_number == 5):
					damageStrength = 10
				else:
					damageStrength = 15
				if ($Sprite.flip_h == true):
					$Animation.play("Attack_1_left")
				else:
					$Animation.play("Attack_1")
		elif Input.is_action_pressed("player_three_attack_2"):
			if (!dead):
				playAttack()
				if (lightning_powered):
					shoot_lightning()
					lightning_powered = false
				else:
					if( character_number == 5):
						damageStrength = 15
					else:
						damageStrength = 20
					if ($Sprite.flip_h == true):
						$Animation.play("Attack_2_left")
					else:
						$Animation.play("Attack_2")
		elif Input.is_action_pressed("player_three_shield"):
			if (!dead && shield_recharge == 0):
				$Animation.play("Shield")
		elif Input.is_action_pressed("player_three_right"):
			motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$CollisionPolygon2D.scale.x = 1
			$Animation.play("Run")
		elif Input.is_action_pressed("player_three_left"):
			motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$CollisionPolygon2D.scale.x = -1
			$Animation.play("Run")
		else:
			$Animation.play("Idle")
			attacking = false
			friction = true

		if is_on_floor():
			if Input.is_action_just_pressed("player_three_jump"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if motion.y < 0:
				$Animation.play("Jump")
			else:
				#$Sprite.play("Fall")
				pass

func power_up_second_chance():
	if (dead):
		$Sounds/PowerUpSounds/SecondChance.play()
		health = 100
		exposed = true
		dead = false
		$Sprite.set_modulate("ffffff")
	else:
		power_up_heart()
	

func power_up_invincible():
	if (!dead):
		$Sounds/PowerUpSounds/Invincible.play()
		var sparkleObj  = Sparkle.instance()
		sparkleObj.set_position(Vector2(0,-5))
		self.add_child(sparkleObj)
		invincible = true


func flash():
	if !dead:
		$Sprite.set_modulate(Color(1,0.541176,0.541176,1))
		_flash_timer = Timer.new()
		add_child(_flash_timer)
		_flash_timer.connect("timeout", self, "_on_flash_timeout")
		_flash_timer.set_wait_time(0.2)
		_flash_timer.set_one_shot(true) # Make sure it loops 1,0.541176,0.541176,1
		_flash_timer.start()

func power_up_heart():
	if (!dead):
		$Sounds/PowerUpSounds/Health.play()
		var heartObj  = Heart.instance()
		heartObj.set_position(Vector2(0,2))
		self.add_child(heartObj)
		health += 20
	else:
		power_up_second_chance()

func power_up_lightning():
	if (!dead):
		$Sounds/PowerUpSounds/LightningStrike.play()
		lightning_powered = true


func power_up_fireball():
	if (!dead):
		fireball_timer = 10
		$Sounds/PowerUpSounds/Fireball.play()
	

func power_up_double_damage():
	if (!dead):
		double_damage_timer = 50
		$Sounds/PowerUpSounds/DoubleDamage.play()

func shoot_lightning():
	
	var lightningObj  = Lightning.instance()
	
	if ($Sprite.flip_h == true):
		lightningObj.set_position(Vector2(-60,0))
	else:
		lightningObj.set_position(Vector2(60,0))
	self.add_child(lightningObj)


func shoot_fireball():
	
	var fireballObj  = Fireball.instance()
	
	if ($Sprite.flip_h == true):
		fireballObj.set_position(Vector2(-12,0))
	else:
		fireballObj.set_position(Vector2(12,0))
	self.add_child(fireballObj)

func _on_flash_timeout():
	$Sprite.set_modulate(Color(1,1,1,1))


func _on_Timer_timeout():
	if (fireball_timer > 0):
		shoot_fireball()
		fireball_timer -= 1
	else:
		pass

func playAttack():
	if attack_sound_timer == 0:
		var rand = randInt(1,6)

		if (rand == 5):
			$Sounds/Hit5.play()
		elif (rand == 4):
			$Sounds/Hit4.play()
		elif (rand == 3):
			$Sounds/Hit3.play()
		elif (rand == 2):
			$Sounds/Hit2.play()
		else:
			$Sounds/Hit1.play()
		attack_sound_timer = 80

func playHurt():
	if hurt_timer == 0:
		var rand = randInt(1,6)

		if (rand == 5):
			$Sounds/Hurt5.play()
		elif (rand == 4):
			$Sounds/Hurt4.play()
		elif (rand == 3):
			$Sounds/Hurt2.play()
		elif (rand == 2):
			$Sounds/Hurt2.play()
		else:
			$Sounds/Hurt1.play()
		hurt_timer = 90

func randInt(int_min, int_max):
	randomize()
	return int (rand_range(int_min, int_max+1))

func _on_Double_Timer_timeout():
	if (!dead):
		
		if (double_damage_timer > 0):
			if ($Sprite.modulate == Color(255, 255, 255, 255) || $Sprite.modulate == Color(1, 1, 1, 1)):
			
				$Sprite.set_modulate(Color(0.454902,0.003922,0.003922,1))
			elif ($Sprite.modulate == Color(116, 1 ,1, 255) || $Sprite.modulate == Color(0.454902,0.003922,0.003922,1) || $Sprite.modulate == Color("740101") ):
		
				$Sprite.set_modulate(Color(1,1,1,1))
			double_damage_timer -= 1
			damge_multi = 2
		else:
			if ($Sprite.modulate == Color(116, 1 ,1, 255) || $Sprite.modulate == Color(0.454902,0.003922,0.003922,1) || $Sprite.modulate == Color("740101")  ):
			
				$Sprite.set_modulate(Color(1,1,1,1))
			damge_multi = 1
			pass

func _on_Animation_animation_finished(anim_name):
	if (anim_name == "Die"):
		player_control = true
		dead = true
