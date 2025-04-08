class_name TestCreatureState
extends Node

var parent : TestCreature

# Shared variables
@onready var player : Player = %Player

# Unique variables
@export var movement_speed : float = 3.5
@export var turn_speed : float = 10.0


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_physics(delta : float) -> TestCreatureState:
	# Add the gravity.
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * delta
		
	# Rotate player based on movement direction
	var look_position : Vector3 = parent.global_position + Vector3(parent.velocity.x, 0.0, parent.velocity.z)
	var turn_direction : Vector3 = -parent.global_position.direction_to(look_position)
	if turn_direction != Vector3.ZERO:
		var target : Basis = Basis.looking_at(turn_direction)
		if not parent.global_transform.origin.is_equal_approx(look_position):
			parent.shape.basis = parent.shape.basis.slerp(target, turn_speed * delta)
	
	return null
	
	
func process_frame(delta : float) -> TestCreatureState:
	return null
	
	
func process_input(event : InputEvent) -> TestCreatureState:
	return null
