extends KinematicBody2D

var velocity = Vector2()
var is_grounded

const UP = Vector2(0, -1)
const SLOPE_STOP = 64

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000

onready var anim_player = get_node("Body/CharacterRig/AnimationPlayer")

onready var raycasts = $RayCasts

func _handle_move_input():
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)
	var move_dir = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	velocity.x = lerp(velocity.x, speed * move_dir, _get_h_weight())
	if(move_dir != 0):
		$CharacterVFX.scale.x = move_dir

func _apply_gravity(delta):
	velocity.y += gravity * delta
	
	is_grounded = _check_is_ground()

func _get_h_weight(): 
	return 0.2 if is_grounded else 0.1

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	
	return false
