extends StateMachine

func _ready() -> void:
	add_state("patrol")
	add_state("chase")
	call_deferred("set_state", states.patrol)

func _state_logic(delta):
	parent._apply_movement()
	print(parent.is_player_here)

func _get_transition(delta):
	match state:
		states.patrol:
			if parent.is_player_here == true:
				return states.chase
		states.chase:
			if parent.is_player_here == false:
				return states.patrol
			
 
func _enter_state(new_state, old_state):
	parent.state_label.set_text(states.keys()[state])
	match state:
		states.patrol:
			parent.anim_enemy.play("patrol_anim")
		states.chase:
			parent.anim_enemy.play("chase_anim")

func _exit_state(old_state, new_state):
	pass
