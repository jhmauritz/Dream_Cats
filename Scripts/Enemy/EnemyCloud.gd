extends KinematicBody2D

onready var health = max_health setget _set_health
onready var is_player_radius = $PlayerCheck
onready var state_label = $Label
onready var anim_enemy = $EnemyAnim
onready var pointA = $PointA
onready var pointB = $PointB

const UP = Vector2(0, -1)
const SLOPE_STOP = 64
const speed = 300

var is_player_here = false
var velocity = Vector2()
var player = null
var pointApos = null
var pointBpos = null
var current_waypoint = null

export (float) var max_health = 100

func _ready() -> void:
	_save_point_pos()

func _save_point_pos():
	pointApos = pointA.global_position
	pointBpos = pointB.global_position
	current_waypoint = pointApos

func _apply_movement():
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)
	
	if player != null:
		_chase()
	else:
		patrol()

func _chase():
	velocity = position.direction_to(player.position) * speed

func patrol():
	if abs(current_waypoint.x - global_position.x) < 10:
		if current_waypoint == pointApos:
			current_waypoint = pointBpos
		elif current_waypoint == pointBpos:
			current_waypoint = pointApos
	
	velocity = position.direction_to(current_waypoint) * speed

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
		player = body


func _on_PlayerCheck_body_exited(body: Node) -> void:
	if body.has_method("_player_ref"):
		is_player_here = false
		player = null
	
func _enemy_ref():
	pass
