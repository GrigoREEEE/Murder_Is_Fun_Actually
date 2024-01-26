extends CharacterBody2D


@export var speed = 300.0
@export var friction = 0.1
@export var acceleration = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):
	if (event.is_action_pressed("jump") and !event.is_echo()):
		if is_on_floor():
			print("going!")
			velocity.y -= 500
			print(velocity.y)

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if (direction.x < 0):
		$Sprite2D.flip_h = true
	elif (direction.x < 0):
		$Sprite2D.flip_h = false
	
	if is_on_floor():
		$Sprite2D.rotation = 0
		if abs(direction.x) > 0:
			velocity.x = velocity.lerp(direction.normalized() * speed, acceleration).x
		else:
			velocity.x = velocity.lerp(Vector2.ZERO, friction).x
	else:
		velocity.y += gravity * delta
		print("Direction is "+ str(direction))
		#$Sprite2D.look_at(transform.origin + velocity)
		velocity.x = velocity.x + min(10, abs(direction.x * speed * 0.5)) * direction.x
	
	move_and_slide()
