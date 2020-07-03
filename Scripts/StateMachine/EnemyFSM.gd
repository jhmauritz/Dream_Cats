extends StateMachine

func _ready() -> void:
	add_state("patrol")
	add_state("chase")
	call_deferred("set_state", states.patrol)

func _state_logic(delta):
	parent._apply_velocity()

func _get_transition(delta):
	match state:
		states.patrol:

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
