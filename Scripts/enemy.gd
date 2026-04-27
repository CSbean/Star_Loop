extends CharacterBody3D
class_name Enemy

## 0 = normal enemy, 1 = boss enemy
@export var boss = 0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $EnemySprite/AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var looker: RayCast3D = $Looker
# normal coler 467876
@onready var base_alien: MeshInstance3D = $EnemySprite/RootNode/AlienArmature/Skeleton3D/BaseAlien

var health := 100
var state : String = "Idle"
var player : CharacterBody3D
var spd := 2.5
var canHitPlayer = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("AlienArmature|Alien_Run")
	var mat = base_alien.get_active_material(1)
	if boss == 1:
		mat.albedo_color = Color(0.17, 0.613, 0.0, 1.0);
		spd = 4.5
	else:
		mat.albedo_color = Color(0.273, 0.47, 0.463, 1.0);
		spd = 2.5
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if GameManager.paused == false:
		var destination = navigation_agent_3d.get_next_path_position()
		var local_destination = destination - self.global_position
		var direction = local_destination.normalized()
		
		self.velocity = direction * spd
		
		look_at(player.global_position, Vector3.UP)
		
		if not is_on_floor():
			velocity += get_gravity() * delta
		move_and_slide()
		var x = randi_range(0,360)
		var y = randi_range(0,360)
		looker.rotate_y(x)
		looker.rotate_x(y)
		if (looker.get_collider() is Player):
			navigation_agent_3d.target_position = player.global_position
		
		if (health <= 0):
			self.queue_free()

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
