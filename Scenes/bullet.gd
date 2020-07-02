extends KinematicBody2D

var velocity = Vector2.ZERO

const bull_velocity = Vector2(800, 0)

func _physics_process(delta):
	velocity.y += 500 * delta
	var collision = move_and_collide(velocity * delta)
	if(collision != null):
		queue_free()

func shoot(direction):
	var temp = global_transform
	var scene = get_tree().current_scene
	get_parent().remove_child(self)
	scene.add_child(self)
	global_transform = temp
	velocity = bull_velocity * Vector2(direction, 1)
