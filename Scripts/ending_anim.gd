extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_3d: Camera3D = $ship/Camera3D
var showCredits := false
@onready var end_credits: Control = $EndCredits
@onready var timer_2: Timer = $EndCredits/Timer2
@onready var player2: Player = $Player
@onready var spaceship_vroom: AudioStreamPlayer = $"spaceship vroom"

func _ready() -> void:
	camera_3d.current = true
	player2.ui.visible = false
	player2.ui.health_img.visible = false
func _process(delta: float) -> void:
	if (showCredits):
		end_credits.global_position.y -= 40*delta

func _on_timer_timeout() -> void:
	showCredits = true
	end_credits.visible = true 
	timer_2.start()
	

func _on_timer_2_timeout() -> void:
	player2.change_mouse()
	GameManager.change_map(1)
	
