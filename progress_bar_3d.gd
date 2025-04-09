class_name ProgressBar3D
extends Node3D

signal progress_changed

@export_range(0.0, 1.0, 0.01) var progress_ratio : float:
	set(value):
		progress_changed.emit()
		progress_ratio = clamp(value, 0.0, 1.0)

@onready var sprite : Sprite3D = $Sprite3D


func _ready() -> void:
	progress_changed.connect(_on_progress_changed)
	progress_ratio = progress_ratio

func _on_progress_changed() -> void:
	sprite.material_override.set_shader_parameter("progress", progress_ratio)
	
