extends Node3D
@onready var pickup_key_card: MeshInstance3D = $"Root Scene/RootNode/Pickup_KeyCard"

@export var img : CompressedTexture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickup_key_card.material_override.albedo_texture = img
	





func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		pass
