class_name PlayerStateController
extends Node

signal state_changed(previous, new)

@export var starting_state: PlayerState

var current_state: PlayerState:
	set(new):
		if current_state != new:
			state_changed.emit(current_state, new)
			if current_state:
				current_state.exit()
			current_state = new
			current_state.enter()


func init(player : Player) -> void:
	# Initialize parents for each state
	for child in get_children():
		child.parent = player
	
	# Initialize current state
	current_state = starting_state


# Pass through functions for the state machine to call,
# handling state changes as needed
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		current_state = new_state


func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		current_state = new_state


func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		current_state = new_state
