extends Node3D
#Preliminary code to have the door open for the player
#All doors will have to be instantiated from this scene
@export var keycard : int
var player : Player
var nearby := false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var isOpen := false
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var root_scene_door_single: MeshInstance3D = $RootSceneDoorSingle
@onready var timer: Timer = $Timer
var isOpening := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if (keycard == 0):
		#set color based on card
		pass
	
func _process(_delta: float) -> void:
	isOpening = animation_player.is_playing()
	if (player.global_position.distance_squared_to(self.global_position) < 25):
		nearby = true
		player.ui.nearby = true
	else:
		nearby = false
		player.ui.nearby = false
	if (self.nearby):
		if (Input.is_action_just_pressed("interact") and !(isOpening)):
			if (player.keycard>=keycard):
				if !(isOpen):
					timer.start(6.4)
					animation_player.play("Open")
					isOpen = true
				else:
					isOpen = false
					animation_player.play("Close")
			else:
				#fail opening
				pass

func _on_timer_timeout() -> void:
	animation_player.play("Close")
