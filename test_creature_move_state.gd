extends TestCreatureState

@export_group("States")
@export var fall_state : TestCreatureState
@export var scared_state : TestCreatureState
@export var curious_state : TestCreatureState
@export var idle_state : TestCreatureState

var move_pos : Vector3 # Random position
var move_dir : Vector3 # The normalized random position assigned when entering the move state


func enter() -> void:
	move_dir = move_pos.normalized()


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
	
	# Move to move position
	parent.velocity = move_dir * movement_speed
	parent.move_and_slide()
	if parent.global_position == move_pos:
		return idle_state
	
	return null
