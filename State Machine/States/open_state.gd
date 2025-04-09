extends TimeState


func enter() -> void:
	print("Entering Open State")


func exit() -> void:
	print("Exiting Open State")


func process_input(event: InputEvent) -> TimeState:
	if %Sky/AnimationPlayer.current_animation_position >= 630:
		print(%Sky/AnimationPlayer.current_animation_position)
		return close_state
	return null


func process_physics(delta: float) -> TimeState:
	return null


func process_frame(delta: float) -> TimeState:
	return null


func _on_time_controller_time_open(time: float) -> void:
	pass # Replace with function body.
