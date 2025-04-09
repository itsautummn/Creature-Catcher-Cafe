extends TestCreatureState

signal creature_tamed

@export_group("States")
@export var scared_state : TestCreatureState
@export_group("Nodes")
@export var tame_bar : ProgressBar3D
@export_group("Stats")
@export_range(0.0, 1.0, 0.01) var tame_speed : float = 1.0


func enter() -> void:
	super()
	tame_bar.visible = true


func exit() -> void:
	super()
	tame_bar.visible = false
	tame_bar.progress_ratio = 0.0


func process_physics(delta : float) -> TestCreatureState:
	# Increase tame bar
	tame_bar.progress_ratio += (delta * tame_speed)
	
	# Check if tame bar is finished filling
	if tame_bar.progress_ratio == 1.0:
		creature_tamed.emit()
	
	# Check if player is moving
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		return scared_state
		
	
	return null
