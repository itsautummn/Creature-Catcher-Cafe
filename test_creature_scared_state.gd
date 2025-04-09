extends TestCreatureState

@export_group("States")
@export var fall_state : TestCreatureState
@export var idle_state : TestCreatureState
@export_group("Timers")
@export var move_timer : Timer

var move_time : float = 2 # Time of being scared
var move_dir : Vector3 # Normalized movement direction opposite of player


func enter() -> void:
	super()
	move_dir = -(player.global_position - parent.global_position).normalized()
	move_timer.wait_time = move_time
	move_timer.start()


func exit() -> void:
	super()
	move_timer.stop()
	move_timer.wait_time = 1.0


func process_physics(delta : float) -> TestCreatureState:
	super(delta) # Body movement
	
	# Check falling
	if not parent.is_on_floor():
		return fall_state
	
	# Move to move position
	parent.velocity = move_dir * movement_speed
	parent.move_and_slide()
	if move_timer.is_stopped():
		# Check if player is still in the scared area
		for body in parent.bodies_in_scared_area:
			if body.is_in_group("player"):
				enter()
				
		return idle_state
	
	return null
