class_name TimeStateMachine
extends Node

signal state_changed(previous: TimeState, new: TimeState)

@export var starting_state: TimeState

var current_state: TimeState:
	set(new):
		if current_state != new:
			state_changed.emit(current_state, new)
			if current_state:
				current_state.exit()
			current_state = new
			current_state.enter()


# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state
func init(parent: TimeController) -> void:
	for child in get_children():
		child.parent = parent
	
	# Initialize to the default state%Sky
	current_state = starting_state


# Pass through functions for the state machine to call,
# handling state changes as needed
func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		current_state = new_state


func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		current_state = new_state


func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		current_state = new_state
