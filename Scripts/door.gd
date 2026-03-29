extends Node3D
#Preliminary code to have the door open for the player
#All doors will have to be instantiated from this scene
var player : Player
var nearby := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (player.global_position.distance_to(self.global_position) < 10):
		nearby = true
	else:
		nearby = false
