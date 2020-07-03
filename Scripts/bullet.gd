extends Area2D

const speed = 800
var velocity = Vector2()
var dir = 1

func _ready():
	if dir == -1:
		$bullet_sprite.flip_h = true

func set_bullet_direction(direction):
	direction = dir
	if dir == -1:
		$bullet_sprite.flip_h = true

func _physics_process(delta):
	velocity.x = speed * delta * dir
	translate(velocity)
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area: Area2D) -> void:
	if area.has_method("_enemy_ref"):
		queue_free()
		area.enemy_damage(20)


func _on_Bullet_body_shape_entered(body_id: int, body: Node, body_shape: int, area_shape: int) -> void:
	if body.has_method("_enemy_ref"):
		queue_free()
		body.enemy_damage(20)
