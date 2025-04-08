extends PlayerState


func process_physics(delta : float) -> PlayerState:
	super(delta) # Body movement
	
	# Check falling
	if not parent.is_on_floor():
		return fall_state
	
	# Check jumping
	if Input.is_action_just_pressed("move_jump") and parent.is_on_floor():
		return jump_state
	
	# Check moving
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		# Check sprinting
		if Input.is_action_pressed("move_sprint"):
			return sprint_state
		return walk_state
	
	return null
