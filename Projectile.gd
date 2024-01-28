extends CharacterBody2D


var direction = Vector2.ZERO
var speed = 1000
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	velocity = direction * speed
	$Explosion_Timer.start()
	
func _physics_process(delta):
	velocity.y += gravity * delta
	
	var collision = move_and_collide(velocity * delta)
	if !collision: return
	
	velocity = velocity.bounce(collision.get_normal()) * 0.6
	
	


func _on_explosion_timer_timeout():
	$Explosion_Area.monitoring = true
	$Explosion.show()
	$Explosion.get_node("Fire").emitting = true
	$Explosion.emitting = true
	$Sprite2D.hide()
	$Explosion_Life.start()


func _on_explosion_life_timeout():
	self.queue_free()


func _on_explosion_area_body_entered(body):
	if (body.name in ["Head", "Arm_Right", "Arm_Left", "Legs", "Torso"]):
		print("Body Enter!")
