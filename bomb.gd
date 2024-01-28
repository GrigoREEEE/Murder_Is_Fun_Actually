extends RigidBody2D

@onready var explosion_path = preload("res://Particle Effects/explosion.tscn")

func _ready():
	$Explosion.hide()

func _on_explosion_area_area_entered(area):
	pass # Replace with function body.


func _on_explosion_timer_timeout():
	$Explosion_Area.monitoring = true
	"""var explosion = explosion_path.instantiate()
	explosion.position = self.position
	self.add_child(explosion)"""
	$Explosion.show()
	$Explosion.emitting = true
	$Sprite2D.hide()
	$Explosion_Life.start()


func _on_explosion_life_timeout():
	self.queue_free()
