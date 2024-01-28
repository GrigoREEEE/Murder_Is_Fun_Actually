extends Line2D

	
func update_trajectory(dir, speed, gravity, delta):
	var max_points = 100
	clear_points()
	var pos = get_parent().get_node("Shoot_Pos").position
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		var collision = $Collision_Math.move_and_collide(vel * delta, false, true, true)
		if collision:
			vel = vel.bounce(collision.get_normal()) * 0.6
		pos += vel * delta
		$Collision_Math.position = pos
