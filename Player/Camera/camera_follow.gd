extends Camera3D

@export var camera_follow : Node3D
@export var lerp_speed : float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = lerp(global_position, camera_follow.global_position, delta * lerp_speed)


func change_follow_node(new : Node3D):
	camera_follow = new
