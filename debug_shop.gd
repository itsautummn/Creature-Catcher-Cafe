extends Label


#func _on_state_machine_state_changed(previous: TimeState, new: TimeState) -> void:
	#text = "Open" if TimeG.is_state_open(new) else "Closed"


func _on_time_controller_time_open(time: float) -> void:
	text = "Open"


func _on_time_controller_time_close(time: float) -> void:
	text = "Closed"
