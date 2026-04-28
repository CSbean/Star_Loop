extends Node3D
@export var pickup_key_card: MeshInstance3D 
@export var texture : Texture2D
## 0=no door acsees, 1=white, 2=green, 3=yellow, 4=red
@export var img : int
var player2 : Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player2 = get_tree().get_first_node_in_group("Player")
	if (img == 2):
		texture = load("res://Assets/keycard Images/green-Pickup Key Card_Atlas.png")
	elif (img == 4):
		texture = load("res://Assets/keycard Images/red-Pickup Key Card_Atlas.png")
	elif(img == 3):
		texture= load("res://Assets/keycard Images/yellow-Pickup Key Card_Atlas.png")
	pickup_key_card.get_surface_override_material(0).albedo_texture = texture

var playerNearby := false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		playerNearby = true
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		playerNearby = false

func _process(_delta: float) -> void:
	if (playerNearby):
		if(Input.is_action_just_pressed("interact")):
			if img >= GameManager.keycardNum:
				GameManager.keycardNum =img
				player2.keycard = img
				queue_free()
