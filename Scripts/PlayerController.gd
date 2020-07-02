extends KinematicBody2D
 
const UP = Vector2(0, -1)
const SLOPE_STOP = 64

var velocity = Vector2()
var move_speed = 96*5
var gravity = 1200
var jump_velocit = -720
var is_grounded
var bullet = null

const bullet_pl = preload("res://Scenes/bullet.tscn")
var move_direction

onready var raycasts = $RayCasts
onready var anim_player = $CharacterRig/AnimationPlayer
onready var state_label = $Label
onready var shootpoint = $CharacterRig/Torso_lower/ArmsGun/shoot_point

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

func _get_h_weight():
	return 0.2 if is_grounded else 0.1

func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func spawn_bullet():
	if Input.is_action_pressed("shoot"):
		var bull_ints = bullet_pl.instance()
		shootpoint.add_child(bull_ints)
	
	
	
	
	
	
	
	
	
	
	
	
	
