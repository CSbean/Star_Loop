extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_3d: Camera3D = $ship/Camera3D

func _ready() -> void:
	camera_3d.current = true

func _on_animation_player_current_animation_changed(name: StringName) -> void:
	#get_tree().quit()
	pass
