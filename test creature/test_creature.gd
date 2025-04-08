class_name TestCreature
extends CharacterBody3D

@onready var state_machine : TestCreatureStateMachine = $CreatureStateMachine
@onready var scared_area : Area3D = $ScaredArea
@onready var curious_area : Area3D = $CuriousArea
@onready var shape : Node3D = $Shape

var bodies_in_scared_area : Array = []
var bodies_in_detection_area : Array = []


func _ready() -> void:
	state_machine.init(self)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _on_scared_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("player_entered")
		bodies_in_scared_area.append(body)


func _on_scared_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("player_exited")
		bodies_in_scared_area.erase(body)
