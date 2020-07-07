extends KinematicBody2D
 
signal health_update(health)
signal killed()

const UP = Vector2(0, -1)
const SLOPE_STOP = 64
const bullet_pl = preload("res://Scenes/Player/bullet.tscn")

var velocity = Vector2()
var move_speed = 96*5
var gravity = 1200
export (float) var jump_velocit = -720
var is_grounded
var bullet = null
var move_direction

export (float) var max_health = 100

onready var health = max_health setget _set_health
onready var raycasts = $RayCasts
onready var anim_player = $CharacterRig/AnimationPlayer
onready var state_label = $Label
onready var shootpoint = $CharacterRig/Torso_lower/ArmsGun/ShootPoint
onready var invulnerabilitytimer = $InvulnerabilityTimer
onready var effects_anim = $EffectsAnimation

func _apply_gravity(delta):
	velocity.y += gravity * delta

func _apply_movement():
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)
	
	is_grounded = _check_is_grounded()

func _handle_move_input():
	var move_dir = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	velocity.x = lerp(velocity.x, move_speed * move_dir, _get_h_weight())
	move_direction = move_dir
	if move_dir != 0:
		$CharacterRig.scale.x = move_dir
		shootpoint.scale.x = move_dir

func _get_h_weight():
	return 0.2 if is_grounded else 0.1

func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func spawn_bullet():
	if Input.is_action_just_pressed("shoot"):
		var bull_inst = bullet_pl.instance()
		if shootpoint.scale.x == 1:
			bull_inst.dir = 1
		else:
			bull_inst.dir = -1
		get_parent().add_child(bull_inst)
		bull_inst.position = shootpoint.global_position

func damage(amount):
	if invulnerabilitytimer.is_stopped():
		invulnerabilitytimer.start()
		#Global.emit_signal("healthbar_updated", health)
		_set_health(health - amount)
		get_node("Healthbar")._on_health_update(health, 3)
		effects_anim.play("damage")
		effects_anim.play("invulnerable")

func kill():
	queue_free()

func _set_health(value):
	var prev_health = health
	health = clamp (value, 0, max_health)
	if health != prev_health:
		if health == 0:
			kill()
			emit_signal("killed")

func _on_InvulnerabilityTimer_timeout() -> void:
	effects_anim.play("rest")
	
func _player_ref():
	pass
