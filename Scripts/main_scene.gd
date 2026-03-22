extends Node3D
@onready var ship: Node3D = $Ship
@onready var space_objects: Node3D = $"Space Objects"
var shipSpd := .083
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	space_objects.global_position -=Vector3(0,0,shipSpd)
