class_name TimeController
extends Node3D

signal time_open(time: float) # In Hours
signal time_close(time: float) # In Hours

@onready var state_machine = $StateMachine

var time_seconds: float
var time_hours: float
var is_stopped: bool

# Signal Handler Variables
var open_sent: bool:
	set(value):
		if not open_sent:
			time_open.emit(time_hours)
		open_sent = value
var close_sent: bool:
	set(value):
		if not close_sent:
			time_close.emit(time_hours)
		close_sent = value

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	if not is_stopped:
		time_seconds += delta
	seconds_to_hours()
	print("Hour: ", time_hours)
	signal_handler()


# Converts the time in seconds to time in minutes, which every minute is an in-game hour
func seconds_to_hours():
	time_hours = floorf(time_seconds / 60)


func signal_handler():
	if time_hours == 1 and not open_sent:
		open_sent = true
	elif time_hours == 9 and not close_sent:
		close_sent = true
