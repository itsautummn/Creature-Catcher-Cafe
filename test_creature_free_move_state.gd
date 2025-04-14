extends TestCreatureState

@export_group("States")
@export var fall_state : TestCreatureState
@export var idle_state : TestCreatureState
@export_group("Timers")
@export var move_timer : Timer

var move_dir : Vector3 # The normalized random position assigned before entering the move state
var move_time : float # Random time assigned before entering the move state


func enter() -> void:
	move_timer.wait_time = move_time
	move_timer.start()


func exit() -> void:
	move_timer.stop()
	move_timer.wait_time = 1.0


func process_physics(delta : float) -> TestCreatureState:
	super(delta)
	
	# Check falling
	if not parent.is_on_floor():
		return fall_state
	
	# Move to move position
	parent.velocity = move_dir * movement_speed
	parent.move_and_slide()
	if move_timer.is_stopped():
		return idle_state
	
	return null


func process_input(event : InputEvent) -> TestCreatureState:
	super(event)
	
	for body in parent.bodies_in_scared_area:
		if body.is_in_group("player"):
			if event.is_action_pressed("interact"):
				print("toggled free move of creature")
	
	return null
