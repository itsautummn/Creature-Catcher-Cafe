extends TimeState


func enter() -> void:
	print("Entering Sleep State")
	

func exit() -> void:
	print("Exiting Sleep State")


func process_input(event: InputEvent) -> TimeState:
	if %Sky/AnimationPlayer.current_animation_position >= 0:
		print(%Sky/AnimationPlayer.current_animation_position)
		return wake_state
	return null


func process_physics(delta: float) -> TimeState:
	return null


func process_frame(delta: float) -> TimeState:
	return null
