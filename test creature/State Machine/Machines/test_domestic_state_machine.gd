class_name TestDomesticStateMachine
extends Node

@export var starting_state : TestCreatureState
var current_state : TestCreatureState


func init(parent : TestCreature) -> void:
	for child in get_children():
		print(child)
		child.parent = get_parent().creature
	current_state = starting_state
	

func process_physics(delta : float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		current_state = new_state


func process_frame(delta : float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		current_state = new_state


func process_input(event : InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		current_state = new_state
