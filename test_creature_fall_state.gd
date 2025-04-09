extends TestCreatureState

@export_group("States")
@export var idle_state : TestCreatureState


func process_physics(delta : float) -> TestCreatureState:
	super(delta)
	
	# Check on floor
	if parent.is_on_floor():
		return idle_state
		
	parent.move_and_slide()
	
	return null
