extends TimeState


func enter() -> void:
	print("Entering Close State")


func exit() -> void:
	print("Exiting Close State")


func process_input(event: InputEvent) -> TimeState:
	if %Sky/AnimationPlayer.current_animation_position >= 720:
		print(%Sky/AnimationPlayer.current_animation_position)
		return sleep_state
	return null


func process_physics(delta: float) -> TimeState:
	return null


func process_frame(delta: float) -> TimeState:
	return null
