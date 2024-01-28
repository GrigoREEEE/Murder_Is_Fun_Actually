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


func _on_explosion_area_area_entered(area):
	var dir = [-1,1]
	if area.name == "Character_Area":
		print(area.get_parent().name)
		area.get_parent().get_node("Body_Area").set_deferred("disabled", true)
		#var direction = Vector2(randi()%5, randi()%5).normalized()
		for i in area.get_parent().get_children():
			if i.name in ["Head", "Legs", "Arm_Left", "Arm_Right", "Torso"]:
				var x_direction = (randi() % 10) * dir[(randi() % 2)]
				var y_direction = (randi() % 10) * dir[(randi() % 2)]
				i.was_hit = true
				i.get_node("CollisionShape2D").set_deferred("disabled", false)
				i.fling(Vector2(x_direction,y_direction).normalized())
				
