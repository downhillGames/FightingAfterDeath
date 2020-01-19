extends KinematicBody2D
var damageStrength = 5
const UP = Vector2(0, -1)
var motion = Vector2()
const ACCELERATION = 50
const MAX_SPEED = 250

var movement = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().get_node("Sprite").flip_h == false:
			#$Sprite.flip_h = false
			$Animation.play("FireBlast")
			movement = "right"
	elif get_parent().get_node("Sprite").flip_h == true:
			
			$Animation.play("FireBlast_left")
			
			movement = "left"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement == "right":
			motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
			##$Sprite.flip_h = false
	elif movement == "left":
			motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
					
			###$Sprite.flip_h = true


	motion = move_and_slide(motion, UP)
	for i in range(get_slide_count() - 1):
       var collision = get_slide_collision(i)
       if (collision.collider.name == "Player"):
	         if collision.collider.exposed == true &&  collision.collider.invincible == false && collision.collider != get_parent():
		          collision.collider.takeDamage(damageStrength)
		          self.queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	self.queue_free()
	("HIT")
	pass # Replace with function body.
