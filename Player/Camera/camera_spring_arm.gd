extends Node3D

signal is_aiming(value : bool)

@export var spring_arm : SpringArm3D
@export_group("Camera")
@export var camera : Camera3D
@export_subgroup("Movement")
@export var mouse_sensitivity : float = 0.005
@export_range(0.0, 90.0, 0.1, "radians_as_degrees") var min_vertical_angle : float = -(5 * PI) / 12
@export_range(0.0, 90.0, 0.1, "radians_as_degrees") var max_vertical_angle : float = PI / 4
@export_subgroup("Zoom")
@export var zoom_speed : float = 0.1
@export_range(1.0, 10.0, 0.1, "suffix:m") var min_zoom_length : float = 1.0
@export_range(1.0, 10.0, 0.1, "suffix:m") var max_zoom_length : float = 10.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 

func _unhandled_input(event: InputEvent) -> void:
	# Camera Movement
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation.y = wrapf(rotation.y - event.relative.x * mouse_sensitivity, 0.0, TAU)
		rotation.x = clamp(rotation.x - event.relative.y * mouse_sensitivity, 
						   min_vertical_angle,
						   max_vertical_angle
						   )
	
	# Camera Zoom
	if event.is_action("camera_zoom_in"):
		spring_arm.spring_length = clamp(spring_arm.spring_length - zoom_speed, min_zoom_length, max_zoom_length)
	if event.is_action("camera_zoom_out"):
		spring_arm.spring_length = clamp(spring_arm.spring_length + zoom_speed, min_zoom_length, max_zoom_length)
	
	# Camera Unlock
	if event.is_action_pressed("toggle_camera_lock"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	## Camera Aim
	#if event.is_action("camera_aim"):
		#camera.change_follow_node($CameraAimFollow)
		#is_aiming.emit(true)
	#if event.is_action_released("camera_aim"):
		#is_aiming.emit(false)
		#camera.change_follow_node($SpringArm3D/CameraFollow)
