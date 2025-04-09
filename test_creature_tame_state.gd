extends TestCreatureState

@export_group("States")


func enter() -> void:
	super()
	print("Tamed!")


func process_physics(delta : float) -> TestCreatureState:
	return null
