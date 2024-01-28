extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var was_hit = false
@export var friction = 0.5

func _physics_process(delta):
	#if was_hit or self.name == "Body":	
	velocity.y += gravity * delta
	velocity.x = velocity.lerp(Vector2.ZERO, friction).x
	move_and_collide(velocity * delta)
		#move_and_slide()
		
func fling(dir):
	print(dir)
	print("flinging!")
	velocity = dir * 200
