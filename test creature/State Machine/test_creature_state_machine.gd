class_name TestCreatureStateMachine
extends Node

signal state_machine_changed(previous : TestCreatureStateMachine, new : TestCreatureStateMachine)

@export var creature : TestCreature
@onready var wild_state_machine : Node = $Wild
@onready var domestic_state_machine : Node = $Domestic
var current_state_machine : Node:
	set(new):
		if current_state_machine != new:
			state_machine_changed.emit(current_state_machine, new)
			current_state_machine = new


func init(parent) -> void:
	wild_state_machine.init(parent)
	#domestic_state_machine.init(parent)
	current_state_machine = wild_state_machine


func process_physics(delta : float) -> void:
	current_state_machine.process_physics(delta)
	
	
func process_frame(delta : float) -> void:
	current_state_machine.process_frame(delta)
	
	
func process_input(event : InputEvent) -> void:
	current_state_machine.process_input(event)


func _on_creature_tamed() -> void:
	current_state_machine = domestic_state_machine
