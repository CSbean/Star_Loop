extends Node3D
#@onready var ship: Node3D = $Ship
@onready var ship: Node3D = $Ship
@onready var mesh_instance_3d: MeshInstance3D = $"Space Objects/MeshInstance3D"
@onready var space_objects: Node3D = $"Space Objects"
@export var loopTime := 90.0
@onready var loop_timer: Timer = $loopTimer

var player : Player
var spd : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loop_timer.start(loopTime)
	Engine.time_scale = 1
	player = get_tree().get_first_node_in_group("Player")
	spd = (mesh_instance_3d.global_position.z+50) / loopTime
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !(GameManager.paused):
		mesh_instance_3d.global_position.z -= spd * delta
		player.ui.timer_label.text = str(int(loop_timer.time_left))
		if (loop_timer.time_left < loopTime/10.0):
			player.ui.timer_label.set("theme_override_colors/font_color", Color.RED)


func _on_loop_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _on_win_area_body_entered(body: Node3D) -> void:
	if (body is Player):
		GameManager.paused = true
		player.ui.pause_screen.visible = true
		player.ui.objective.text = "You Won!!"
		player.ui.close_ui.visible = false
