extends Node3D
#Preliminary code to have the door open for the player
#All doors will have to be instantiated from this scene
@export var type : int
var player : Player
var nearby := false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var isOpen := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (player.global_position.distance_squared_to(self.global_position) < 25):
		nearby = true
		player.ui.nearby = true
	else:
		nearby = false
		player.ui.nearby = false
	if (self.nearby):
		if (Input.is_action_just_pressed("interact")):
			if !(isOpen):
				animation_player.play("Open")
			else:
				animation_player.play("RESET")
