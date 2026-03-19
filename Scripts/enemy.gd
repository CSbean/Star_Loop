extends CharacterBody3D

var health := 100
var state : String = "Idle"
#var player = get_tree().get_first_node_in_group("Player")
const SPEED = 5.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
