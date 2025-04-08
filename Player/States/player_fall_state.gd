extends PlayerState


func process_physics(delta : float) -> PlayerState:
	super(delta) # Body movement
	
	move()
	
	# Check on ground
	if parent.is_on_floor():
		# Check moving
		if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
			# Check sprinting
			if Input.is_action_pressed("move_sprint"):
				return sprint_state
			return walk_state
		return idle_state
	
	return null


func move() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction : Vector3 = (parent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
	
	if direction:
		parent.velocity.x = direction.x * movement_speed
		parent.velocity.z = direction.z * movement_speed
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, movement_speed)
		parent.velocity.z = move_toward(parent.velocity.z, 0, movement_speed)
	
	parent.move_and_slide()
