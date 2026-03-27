extends CharacterBody3D
class_name Enemy
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $EnemySprite/AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var health := 100
var state : String = "Idle"
var player : CharacterBody3D
var spd := 5.0
var canHitPlayer = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("AlienArmature|Alien_Run")

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if GameManager.paused == false:
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
	if body is Player:
		canHitPlayer = true
		while canHitPlayer == true:
			animation_player.play("AlienArmature|Alien_Punch")
			await get_tree().create_timer(0.6).timeout
			body.take_damage_p(20)
			await get_tree().create_timer(0.3).timeout
			animation_player.play("AlienArmature|Alien_Run")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		canHitPlayer = false
