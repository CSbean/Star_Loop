extends Node3D
@onready var pickup_key_card: MeshInstance3D = $"Root Scene/RootNode/Pickup_KeyCard"
# 0=no door acsees, 1=white, 2=green, 3=yellow, 4=red
@export var img : int
var player2 : Player
var whiteCard = preload("uid://co5vthwxv5krp")
var greenCard = preload("res://Assets/green-Pickup Key Card_Atlas.png")
var yellowCard = preload("res://Assets/yellow-Pickup Key Card_Atlas.png")
var redCard = preload("res://Assets/red-Pickup Key Card_Atlas.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player2 = get_tree().get_first_node_in_group("Player")
	if img == 1:
		pickup_key_card.material_override.albedo_texture = whiteCard
	elif img == 2:
		pickup_key_card.material_override.albedo_texture = greenCard
	elif img == 3:
		pickup_key_card.material_override.albedo_texture = yellowCard
	elif img == 4:
		pickup_key_card.material_override.albedo_texture = redCard
	

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
				print(img)
