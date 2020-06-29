extends "res://Scripts/StateMachine.gd"

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)

func _apply_movement():
	if[states.idle, states.walk].has(state):
		parent.velocity = parent.move_and_slide(parent.velocity, parent.UP, parent.SLOPE_STOP)
		if Input.is_action_just_pressed("jump") && parent.is_grounded:
			parent.velocity.y = parent.jump_speed

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	_apply_movement()

func _get_transition(delat):
	match state:
		state.idle:
			if!parent.is_on_floor():
				if(parent.velcotiy.y < 0):
					return states.jump
				elif parent.velocity.y >= 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.walk

		state.walk:
			if!parent.is_on_floor():
				if(parent.velcotiy.y < 0):
					return states.jump
				elif parent.velocity.y >= 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
		
		state.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return state.fall

		state.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return state.jump
				
	return null

func _enter_state(new_state, old_state):
	#anims and timers go here
	match new_state:
		states.idle:
			parent.anim_player.play("IdleStance")
		states.walk:
			parent.anim_player.play("Walk")
		states.jump:
			parent.anim_player.play("jump_initial")
		states.fall:
			parent.anim_player.play("jump_initial")

func _exit_state(old_state, new_state):
	pass
