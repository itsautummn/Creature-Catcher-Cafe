extends PlayerState

@export var jump_velocity : float = 4.5


func process_physics(delta : float) -> PlayerState:
	super(delta)
	
	# Handle jump.
	parent.velocity.y = jump_velocity
	
	parent.move_and_slide()
	
	# Check falling
	if parent.velocity.y > 0.0:
		return fall_state
	
	return null
