extends KinematicBody2D

onready var health = max_health setget _set_health
onready var is_player_radius = $PlayerCheck
onready var state_label = $Label
onready var anim_enemy = $EnemyAnim

const UP = Vector2(0, -1)
const SLOPE_STOP = 64
const speed = 300

var is_player_here = false
var velocity = Vector2()

export (float) var max_health = 100

func _apply_movement():
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)

func kill():
	queue_free()

func _set_health(value):
	var prev_health = health
	health = clamp (value, 0, max_health)
	if health != prev_health:
		if health == 0:
			kill()

func enemy_damage(amount):
		_set_health(health - amount)
		get_node("EnemyHealthBar")._on_health_update(health, 3)


func _on_DamageTrigger_body_entered(body: Node) -> void:
	if body.has_method("_player_ref"):
		body.damage(10)


func _on_PlayerCheck_body_entered(body: Node) -> void:
	if body.has_method("_player_ref"):
		is_player_here = true
		velocity = position.direction_to(body.position) * speed


func _on_PlayerCheck_body_exited(body: Node) -> void:
	is_player_here = false
	
func _enemy_ref():
	pass
