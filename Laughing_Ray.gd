extends RayCast2D

var tween
var is_casting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	tween = create_tween()
	set_physics_process(false)
	print($Line2D.points)
	$Line2D.points[1] = Vector2.ZERO # Replace with function body."""
	
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("laser"):
		$Particles.emitting = true
		is_casting = true
		set_physics_process(is_casting)
	if event.is_action_released("laser"):
		$Particles.emitting = false
		is_casting = false
		set_physics_process(is_casting)
		$Line2D.points[1] = Vector2.ZERO
		#$CollisionParticles2D.emitting = false
		#$BeamParticles2D.emitting = false
	#if event is InputEventMouseButton:
	#	self.is_casting = event.pressed
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var cast_point := target_position
	force_raycast_update()
	#self.look_at(get_global_mouse_position())
	#if is_casting:
	#	appear()
	#else:
	#	disappear()
		
	print("The collision is " + str(is_colliding()))
	print("The casting is is " + str(is_casting))
	
	#$CollisionParticles2D.emitting = true
	#$CastingParticles2D.emitting = true
	#$BeamParticles2D.emitting = true
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		#$CollisionParticles2D.global_rotation = get_collision_normal().angle()
		#$CollisionParticles2D.position = cast_point
	
	$Line2D.points[1] = cast_point
	#$BeamParticles2D.position = cast_point * 0.5
	#$BeamParticles2D.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
func set_is_casting(cast: bool) -> void:
	is_casting = cast
	
	"""$BeamParticlesD2.emitting = is_casting
	$CastingParticles2D.emitting = is_casting
	if is_casting:
		appear()
	else:
		$CollisionParticles2D.emitting = false
		disappear()"""
	set_physics_process(is_casting)
