extends Node3D
#@onready var ship: Node3D = $Ship
@onready var space_objects: Node3D = $"Space Objects"
var shipSpd := .64
@onready var ship: Node3D = $Ship
@onready var mesh_instance_3d: MeshInstance3D = $"Space Objects/MeshInstance3D"
var player : Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
			 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	player.ui.timer_label.text = str(150-int(animation_player.current_animation_position))
	if (animation_player.current_animation_position>130):
		player.ui.timer_label.color = Color.RED
	space_objects.global_position -=Vector3(0,0,shipSpd)
	if (ship.global_position.distance_to(mesh_instance_3d.global_position) < 100):
		mesh_instance_3d.global_position = Vector3(0,0,1000)
