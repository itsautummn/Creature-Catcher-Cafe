class_name Player
extends CharacterBody3D

signal player_moving

@onready var state_machine : PlayerStateController = %PlayerStateMachine
@onready var shape : Node3D = $Shape

func _ready() -> void:
	state_machine.init(self)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _input(event: InputEvent) -> void:
	if event.is_action("move_left") or event.is_action("move_right") or event.is_action("move_up") or event.is_action("move_down") or event.is_action("move_jump"):
		player_moving.emit()
