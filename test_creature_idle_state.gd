extends TestCreatureState

@export_group("States")
@export var fall_state : TestCreatureState
@export var scared_state : TestCreatureState
@export var curious_state : TestCreatureState
@export var move_state : TestCreatureState


func process_physics(delta : float) -> TestCreatureState:
	super(delta)
	
	# Check falling
	if not parent.is_on_floor():
		return fall_state
	
	# Check scared or curious
	for body in parent.bodies_in_scared_area:
		if body.is_in_group("player"):
			if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
				return scared_state
			return curious_state
	
	# Check move randomly
	var move_prob : int = randi_range(1, 100)
	if move_prob == 100:
		# Choose a random spot to move to
		# Takes creature position and adds a random vector within a specified range
		var random_pos = Vector3(randf_range(-10.0, 10.0), 0.0, randf_range(-10.0, 10.0))
		random_pos = random_pos
		
		# Set move position to random position chosen
		move_state.move_pos = random_pos
		
		return move_state
	
	return null
