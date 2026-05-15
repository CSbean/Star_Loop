extends Node3D
#@onready var ship: Node3D = $Ship
@onready var ship: Node3D = $Ship
@onready var mesh_instance_3d: MeshInstance3D = $"Space Objects/MeshInstance3D"
@onready var space_objects: Node3D = $"Space Objects"
@export var loopTime := 90.0
@onready var loop_timer: Timer = $loopTimer
@onready var background_music: AudioStreamPlayer = $backgroundMusic
@onready var enemies: Node3D = $Enemies
@onready var win_cam: Camera3D = $WinCam
@onready var reng_audio: AudioStreamPlayer3D = $Ship/LeftEngine/RengAudio
@onready var l_eng_audio: AudioStreamPlayer3D = $Ship/LeftEngine/LEngAudio

var wonMove := false
var player : Player
var spd : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not(GameManager.playAudio):
		background_music.stop()
		reng_audio.playing = false
		l_eng_audio.playing = false
	loop_timer.start(loopTime)
	Engine.time_scale = 1
	player = get_tree().get_first_node_in_group("Player")
	spd = (mesh_instance_3d.global_position.z-100) / loopTime
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Test spd remove \/
	if (Input.is_action_pressed("test_spd") && player.dev_mode):
		Engine.time_scale = 20
	else:
		Engine.time_scale = 1
	if (Input.is_action_just_pressed("mute")):
		GameManager.playAudio = !GameManager.playAudio
		if (background_music.playing):
			background_music.stop()
		else:
			background_music.play()
	if (wonMove):
		space_objects.global_position +=  Vector3(-5*delta, 0, -2*delta)
		ship.rotate(Vector3(0,1,0), .03*delta)
	#if (Input.is_action_just_pressed("dev")):
	#	enemies.queue_free()
	if !(GameManager.paused):
		mesh_instance_3d.global_position.z -= spd * delta
		player.ui.timer_label.text = str(int(loop_timer.time_left))
		if (loop_timer.paused):
			loop_timer.paused = false
		if (loop_timer.time_left < loopTime/10.0):
			player.ui.timer_label.set("theme_override_colors/font_color", Color.RED)
	else:
		if !(loop_timer.paused):
			loop_timer.paused = true

func _on_loop_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _on_win_area_body_entered(body: Node3D) -> void:
	if (body is Player):
		player.change_mouse()
		GameManager.paused = true
		background_music.stop()
		player.ui.pause_screen.visible = true
		player.ui.objective.text = "You Won!!"
		player.ui.close_ui.visible = false
		win_cam.current = true 
		wonMove = true
