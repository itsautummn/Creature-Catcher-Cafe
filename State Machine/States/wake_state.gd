extends TimeState


func enter() -> void:
	print("Entering Wake State")


func exit() -> void:
	print("Exiting Wake State")


func process_input(event: InputEvent) -> TimeState:
	if %Sky/AnimationPlayer.current_animation_position >= 90:
		print(%Sky/AnimationPlayer.current_animation_position)
		return open_state
	return null


func process_physics(delta: float) -> TimeState:
	return null


func process_frame(delta: float) -> TimeState:
	return null
