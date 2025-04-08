class_name TimeState
extends Node

@export var time: TimeG.States

@export var wake_state: TimeState
@export var open_state: TimeState
@export var close_state: TimeState
@export var sleep_state: TimeState


## Hold a reference to the NPC so that is can be controlled by the state
var parent: SkyController


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_input(event: InputEvent) -> TimeState:
	return null


func process_physics(delta: float) -> TimeState:
	return null


func process_frame(delta: float) -> TimeState:
	return null
