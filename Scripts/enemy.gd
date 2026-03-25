extends CharacterBody3D
class_name Enemy
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $EnemySprite/AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var health := 100
var state : String = "Idle"
var player : CharacterBody3D
var spd := 2.5


#func _unhandled_input(event: InputEvent) -> void:
	#if (event.is_action_pressed("ui_accept")):
		#var random_position := Vector3.ZERO
		#random_position.x = randf_range(-12.5,12.5)
		#random_position.z = randf_range(-20,20)
		#navigation_agent_3d.target_position = random_position
		#print(random_position)
	#print(str(global_position) + "\n")
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("AlienArmature|Alien_Run")

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	navigation_agent_3d.target_position = player.global_position
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - self.global_position
	var direction = local_destination.normalized()
	
	self.velocity = direction * spd
	
	look_at(player.global_position)
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()








func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body.name)


func _on_area_3d_area_entered(area: Area3D) -> void:
	print(area.name)
