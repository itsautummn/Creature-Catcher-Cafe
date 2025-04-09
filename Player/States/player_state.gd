class_name PlayerState
extends Node

# All States
@onready var idle_state : PlayerState = %PlayerIdleState
@onready var walk_state : PlayerState = %PlayerWalkState
@onready var sprint_state : PlayerState = %PlayerSprintState
@onready var jump_state : PlayerState = %PlayerJumpState
@onready var fall_state : PlayerState = %PlayerFallState
@onready var aim_state : PlayerState = %PlayerAimState

# Shared Variables
@onready var camera : Camera3D = %PlayerCamera
@onready var spring_arm_pivot : Node3D = %SpringArmPivot
var parent : Player

# Unique Stats
@export var movement_speed : float = 5.0
@export var turn_speed : float = 10.0


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_physics(delta : float) -> PlayerState:
	# Add the gravity.
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * delta
		
	# Rotate player based on movement direction
	var look_position : Vector3 = parent.global_position + Vector3(parent.velocity.x, 0.0, parent.velocity.z)
	var turn_direction : Vector3 = parent.global_position.direction_to(look_position)
	if turn_direction != Vector3.ZERO:
		var target : Basis = Basis.looking_at(turn_direction)
		if not parent.global_transform.origin.is_equal_approx(look_position):
			parent.shape.basis = parent.shape.basis.slerp(target, turn_speed * delta)
	
	return null


func process_frame(delta : float) -> PlayerState:
	return null


func process_input(event : InputEvent) -> PlayerState:
	return null
