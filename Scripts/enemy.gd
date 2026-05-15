extends CharacterBody3D
class_name Enemy

## 0 = normal enemy, 1 = boss enemy
@export var boss := false
@export var sound_pool: Array[AudioStream] = []
@onready var enemy_sprite: Node3D = $EnemySprite

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $EnemySprite/AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var looker: RayCast3D = $Looker
# normal coler 467876
@onready var base_alien: MeshInstance3D = $EnemySprite/RootNode/AlienArmature/Skeleton3D/BaseAlien
@onready var boss_sprite: Node3D = $BossSprite
@onready var boss_anim: AnimationPlayer = $BossSprite/BossAnim
@onready var death_particles: GPUParticles3D = $deathParticles
@onready var head: BoneAttachment3D = $EnemySprite/RootNode/AlienArmature/Skeleton3D/Head
@onready var damage_anim: AnimationPlayer = $EnemySprite/damage_anim

var health := 100
var state : String = "Idle"
var player : CharacterBody3D
var spd := 3.14
var dmg := 20
var canHitPlayer = false
var rng = RandomNumberGenerator.new()
var dead := false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	animation_player.play("AlienArmature|Alien_Run")
	var mat = base_alien.get_active_material(1)
	rng.randomize() # Randomizes the seed based on time
	if boss:
		print("boss")
		spd = 4
		health = 500
		dmg = 50
		enemy_sprite.visible = false 
		boss_sprite.visible = true
	else:
		mat.albedo_color = Color(0.273, 0.47, 0.463, 1.0);
		spd = 2.5
		enemy_sprite.visible = true
		boss_sprite.visible = false
	damage_anim.play("damage")
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if (boss) && (animation_player.is_playing()):
		boss_anim.play(animation_player.current_animation)
	if GameManager.paused == false && !dead:
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
			die()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player :
		canHitPlayer = true
		while canHitPlayer == true && !dead:
			animation_player.play("AlienArmature|Alien_Punch")
			await get_tree().create_timer(0.6).timeout
			play_random_sound()
			if (canHitPlayer) and !(GameManager.paused):
				body.take_damage_p(dmg)
			await get_tree().create_timer(0.3).timeout
			if !(dead):
				animation_player.play("AlienArmature|Alien_Run")

func takeDamage()->void:
	health -= 40
	self.damage_anim.play("damage")
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		canHitPlayer = false

func play_random_sound():
	if GameManager.playAudio:
		if sound_pool.is_empty():
			return
	
	# Picks one random sound from your 24 options
		var random_sound = sound_pool.pick_random()
	
		audio_stream_player.stream = random_sound
		audio_stream_player.play()

func die() -> void:
	#death_particles.global_position = head.global_position
	if !(dead):
		if (boss):
			death_particles.amount = 15000
		dead = true
		collision_shape_3d.queue_free()
		animation_player.current_animation ="AlienArmature|Alien_Death"
		death_particles.emitting = true
		await animation_player.animation_finished
		self.queue_free()
	self.velocity = Vector3.ZERO
