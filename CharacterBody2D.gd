extends CharacterBody2D

var can_shoot = true
var muzzle_velocity = 860
var projectile_direction = Vector2(1,1)
@export var speed = 300.0
@export var friction = 0.1
@export var acceleration = 0.2



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var projectile_path = preload("res://projectile.tscn")




func _unhandled_input(event):
	if event.is_action_released("shoot") and can_shoot:
		var b = projectile_path.instantiate()
		b.global_position = $Shoot_Pos.global_position
		b.direction = projectile_direction
		b.velocity = get_global_mouse_position() * muzzle_velocity
		self.get_parent().add_child(b)
		#$Trajectory_Line/Collision_Math/CollisionShape2D.disabled = true
		#$Trajectory_Line.hide()
	if (event.is_action_pressed("jump") and !event.is_echo()):
		if is_on_floor():
			print("going!")
			velocity.y -= 500
			print(velocity.y)

func _physics_process(delta):
	projectile_direction = (get_global_mouse_position() - $Shoot_Pos.global_position).normalized()
	$Trajectory_Line.update_trajectory(projectile_direction, muzzle_velocity, gravity, delta)
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	
	if (direction.x < 0):
		$Player_Sprite.flip_h = true
		$Shoot_Pos.position.x = -41
		$Trajectory_Line.position.x = -41
	elif (direction.x > 0):
		$Player_Sprite.flip_h = false
		$Shoot_Pos.position.x = 41
		$Trajectory_Line.position.x = 41
		
	if abs(velocity.y) > 0:
		$Player_Sprite.play("jump")
	else:
		if abs(velocity.x) > 10:
			$Player_Sprite.play("walk")
		else:
			$Player_Sprite.play("stand")
	
	if is_on_floor():
		if abs(direction.x) > 0:
			velocity.x = velocity.lerp(direction.normalized() * speed, acceleration).x
		else:
			velocity.x = velocity.lerp(Vector2.ZERO, friction).x
			if (velocity.x < 5):
				velocity.x = 0
	else:
		velocity.y += gravity * delta
		velocity.x = velocity.x + min(10, abs(direction.x * speed * 0.5)) * direction.x
	
	move_and_slide()
