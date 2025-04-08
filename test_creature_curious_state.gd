extends TestCreatureState

@export_group("States")
@export var fall_state : TestCreatureState
@export var scared_state : TestCreatureState
@export var tame_state : TestCreatureState
@export var idle_state : TestCreatureState

var move_pos : Vector3
var move_dir : Vector3
var player_still_in : bool = true


func enter() -> void:
	move_pos = player.global_position - parent.global_position
	move_dir = move_pos.normalized()


func process_physics(delta : float) -> TestCreatureState:
	super(delta)
	
	# Check falling
	if not parent.is_on_floor():
		return fall_state
	
	# Check scared
	player_still_in = false
	for body in parent.bodies_in_scared_area:
		if body.is_in_group("player"):
			player_still_in = true
			if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
				return scared_state
	
	# Check if the player suddently disappeared
	if not player_still_in:
		return idle_state
	
	# Move slowly towards player
	parent.velocity = move_dir * movement_speed
	parent.move_and_slide()
	if parent.velocity <= Vector3.ZERO:
		return tame_state
	
	return null
