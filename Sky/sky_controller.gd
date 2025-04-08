class_name SkyController
extends WorldEnvironment

const DAY_LENGTH_SECONDS : float = 900 # 16 hours

@export_group("Sky Variables")
@export var top_gradient : Gradient
@export var base_gradient : Gradient
@export var scatter_gradient : Gradient
@export_group("Cloud Variables")
@export var cloud_gradient : Gradient
@export_group("Nodes")
@export var sky : Sky
@export var sun : DirectionalLight3D
@export_category("Time")
@export_range(0, DAY_LENGTH_SECONDS, 10) var time : float = 0.0:
	set(value):
		time = value
		if time >= DAY_LENGTH_SECONDS:
			time = 0.0
		update_skybox()
		update_sun()
		
var time_seconds : float:
	get():
		return floorf(time)
var time_hours : float:
	get():
		return floorf(time / 60)
var time_zero_one : float:
	get():
		return time_seconds / DAY_LENGTH_SECONDS


func _ready():
	time = 0.0
	update_skybox()
	update_sun()


func _process(delta: float) -> void:
	time += delta * 50


func update_skybox():
	sky.sky_material.set_shader_parameter("top_color", top_gradient.sample(time_zero_one))
	sky.sky_material.set_shader_parameter("bottom_color", base_gradient.sample(time_zero_one))
	sky.sky_material.set_shader_parameter("sun_scatter", scatter_gradient.sample(time_zero_one))
	sky.sky_material.set_shader_parameter("clouds_light_color", cloud_gradient.sample(time_zero_one))
	
	if time_zero_one < 0.5:
		sky.sky_material.set_shader_parameter("stars_intensity", clamp(5 - (time_zero_one * 30), 0.0, 5.0))
	elif time_zero_one > 0.5:
		sky.sky_material.set_shader_parameter("stars_intensity", clamp(5 - ((1.0 - time_zero_one) * 30), 0.0, 5.0))

func update_sun():
	sun.rotation_degrees = Vector3(-(210 - (time_zero_one * 210)) + 15, 0, 0)
	if time_zero_one < 0.1:
		sun.light_energy = clamp(time_zero_one * 10, 0.0, 1.0)
	elif time_zero_one > 0.9:
		sun.light_energy = clamp((1.0 - time_zero_one) * 10, 0.0, 1.0)
