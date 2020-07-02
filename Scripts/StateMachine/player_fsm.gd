extends StateMachine

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)

func _process(delta):
	parent.spawn_bullet()

func _input(event):
	if[states.idle, states.walk].has(state):
		if event.is_action_pressed("jump"):
			parent.velocity.y = parent.jump_velocit

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement()

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.walk
		states.walk:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.x == 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
	return null

func _enter_state(new_state, old_state):
	parent.state_label.set_text(states.keys()[state])
	
	match new_state:
		states.idle:
			parent.anim_player.play("IdleStanceAnim")
		states.walk: 
			parent.anim_player.play("WalkAnim")
		states.jump:
			parent.anim_player.play("Jump")
		states.fall:
			parent.anim_player.play("Jump")

func _exit_state(old_state, new_state):
	pass
