extends TestCreatureState

@export_group("States")
@export var fall_state : TestCreatureState
@export var idle_state : TestCreatureState

var move_pos : Vector3
var move_dir : Vector3


func enter() -> void:
	super()
	move_pos = player.global_position - parent.global_position
	move_dir = move_pos.normalized()
	move_dir *= -1 # Run away from the player


func process_physics(delta : float) -> TestCreatureState:
	super(delta) # Body movement
	
	# Check falling
	if not parent.is_on_floor():
		return fall_state
	
	
	# Move to move position
	parent.velocity = move_pos * movement_speed
	parent.move_and_slide()
	if parent.velocity <= Vector3.ZERO:
		# Check if player is still in the scared area
		for body in parent.bodies_in_scared_area:
			if body.is_in_group("player"):
				enter()
				
		return idle_state
	
	return null
