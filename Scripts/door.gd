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
var isMoving := false
const YELLOW_DOOR = preload("uid://dvpcoiews1m4i")
const RED_DOOR = preload("uid://dph82iep788ow")
const GREEN_DOOR = preload("uid://cwfun4djjppvb")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if (keycard == 2):
		root_scene_door_single.set_surface_override_material(3,GREEN_DOOR)
	elif (keycard == 3):
		root_scene_door_single.set_surface_override_material(3,YELLOW_DOOR)
	elif (keycard >= 4):
		root_scene_door_single.set_surface_override_material(3,RED_DOOR)

func _process(_delta: float) -> void:
	isMoving = animation_player.is_playing()
	if (player.global_position.distance_squared_to(self.global_position) < 9):
		nearby = true
		player.ui.nearby = true
	else:
		nearby = false
		player.ui.nearby = false
	if (self.nearby):
		if (Input.is_action_just_pressed("interact") and !(isMoving)):
			if (player.keycard+10>=keycard):
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
	if (isOpen):
		animation_player.play("Close")
