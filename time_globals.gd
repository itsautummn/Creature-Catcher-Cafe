extends Node

# Time State Machine Controller
enum States {
	WAKE,
	OPEN,
	CLOSE,
	SLEEP
}

func is_state_open(state: TimeState):
	return state.time == States.OPEN


# ===================
# Reference Variables
# ===================

# Sky Night Colors
@export_category("Sky Night Colors")
@export var night_cloud_color: Color = Color(0.22, 0.44, 1.0)
@export var night_top_color: Color = Color(0.02, 0.1, 0.25)
@export var night_bottom_color: Color = Color(0.02, 0.1, 0.25)
@export var night_sun_scatter_color: Color = Color(0.12, 0.08, 0.37)

# Sky Morning Colors
@export_category("Sky Morning Colors")
@export var morning_cloud_color: Color = Color(0.63, 0.30, 0.60)
@export var morning_top_color: Color = Color(0.69, 0.42, 0.64)
@export var morning_bottom_color: Color = Color(0.56, 0.23, 0.34)
@export var morning_sun_scatter_color: Color = Color(0.45, 0.27, 0.18)

# Sky Day Colors
@export_category("Sky Day Colors")
@export var day_cloud_color: Color = Color("WHITE")
@export var day_top_color: Color = Color(0.34, 0.58, 1.0)
@export var day_bottom_color: Color = Color(0.0, 0.32, 0.96)
@export var day_sun_scatter_color: Color = Color(0.29, 0.29, 0.29)

# Sky Evening Colors
@export_category("Sky Evening Colors")
@export var evening_cloud_color: Color = Color(0.79, 0.34, 0.26)
@export var evening_top_color: Color = Color(0.57, 0.25, 0.19)
@export var evening_bottom_color: Color = Color(0.57, 0.25, 0.19)
@export var evening_sun_scatter_color: Color = Color(0.35, 0.18, 0.28)

# Sky Astro Colors
@export_category("Sky Astro Colors")
@export var moon_color: Color = Color("WHITE")
@export var sun_color: Color = Color(0.9, 0.78, 0.62)
