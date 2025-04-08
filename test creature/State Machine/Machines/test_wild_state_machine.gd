class_name TestWildStateMachine
extends Node

@export var max_love_needed : int
@export var love_increase_speed : float
@export var love : float

@export var starting_state : TestCreatureState
var current_state : TestCreatureState:
	set(new):
		if current_state != new:
			if current_state:
				current_state.exit()
			current_state = new
			current_state.enter()


func init(parent : TestCreature) -> void:
	for child in get_children():
		child.parent = get_parent().creature
	current_state = starting_state
	

func process_physics(delta : float) -> void:
	print(current_state)
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
