extends CharacterBody3D

@export_group("Nodes")
@export var camera : Camera3D
@export var spring_arm_pivot : Node3D
@export_group("Stats")
@export_subgroup("Movement Speed")
@export var base_speed : float = 5.0
@export var sprint_speed : float = 10.0
@export var aim_speed : float = 2.5
@export_subgroup("")
@export var jump_velocity : float = 4.5
@export var turn_speed : float = 10.0

@onready var shape : Node3D = $Shape

var aiming : bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction : Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
	
	# Change speed based on sprinting
	var current_move_speed : float
	current_move_speed = sprint_speed if Input.is_action_pressed("move_sprint") else base_speed
	if aiming:
		current_move_speed = aim_speed
	
	if direction:
		velocity.x = direction.x * current_move_speed
		velocity.z = direction.z * current_move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_move_speed)
		velocity.z = move_toward(velocity.z, 0, current_move_speed)
	
	move_and_slide()
	
	# Rotate player
	if aiming:
		# Rotate player based on camera direction
		var look_position : Vector3 = -Vector3(camera.get_global_transform_interpolated().basis.z.x, 0.0, camera.get_global_transform_interpolated().basis.z.z)
		var turn_direction : Vector3 = global_position.direction_to(look_position)
		if look_position != Vector3.ZERO:
			var target : Basis = Basis.looking_at(look_position)
			if not global_transform.origin.is_equal_approx(look_position):
				shape.basis = shape.basis.slerp(target, turn_speed * delta)
	else:
		# Rotate player based on movement direction
		var look_position : Vector3 = global_position + Vector3(velocity.x, 0.0, velocity.z)
		var turn_direction : Vector3 = global_position.direction_to(look_position)
		if turn_direction != Vector3.ZERO:
			var target : Basis = Basis.looking_at(turn_direction)
			if not global_transform.origin.is_equal_approx(look_position):
				shape.basis = shape.basis.slerp(target, turn_speed * delta)


func _on_spring_arm_pivot_is_aiming(value: bool) -> void:
	aiming = value
