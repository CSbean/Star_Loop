extends CharacterBody3D
class_name Player
@onready var ui: Control = $UI

@onready var camera_3d: Camera3D = $Camera3D
@onready var animation_player: AnimationPlayer = $PlayerSprite/AnimationPlayer
@onready var scifi_pistol: Node3D = $PlayerSprite/RootNode/CharacterArmature/Skeleton3D/BoneAttachment3D/ScifiPistol
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var spot_light_3d: SpotLight3D = $Camera3D/SpotLight3D
@onready var animation_tree: AnimationTree = $AnimationTree
#audio strem players
@onready var walking_audio_stream: AudioStreamPlayer = $walkingAudioStream
@onready var pisto_shoot_audio: AudioStreamPlayer = $pistoShootAudio
@onready var shotgun_shoot_audio: AudioStreamPlayer = $shotgunShootAudio
@onready var ar_shoot_audio: AudioStreamPlayer = $arShootAudio


var SPEED = 5.0
const JUMP_VELOCITY = 4.
var shotgunRounds := 0
var pistolRounds := 0
var rifleRounds := 0
var hasRifle := false
var hasShotgun := false
var hasPistol := false

#camra var's
var look_dir: Vector2
var camra_sense := 50#50
var capMouse := false
var flashOn := false
var sprinting_toggle = false
var pistolVisabilityToggle = false
var health = 100
##AR = 0, Shotgun = 1, Pistol = 2
var inventorySlot = 1
## 0=no door acsees, 1=white, 2=green, 3=yellow, 4=red
var keycard = 0

### TO-DO LIST 
	#Finish MAP!!!!! - Beau
	#Get time loop working - Ben
	#Add Ammo - Ben - DONE
	#Add win/lose ui - Ben
	#Add SFX - Beau
	#Add Start Screen UI + Settings - Ben
	#Add Bossfight

func _ready() -> void:
	change_mouse()

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Flashlight")):
		flashOn = !flashOn
		spot_light_3d.visible = flashOn
	if (Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()
		GameManager.paused = false
	if (Input.is_action_just_pressed("quit")):
		get_tree().quit()
	#dev controls^
	if Input.is_action_just_pressed("esc"):
		change_mouse()
		GameManager.paused = !GameManager.paused
	
	
	if GameManager.paused == false:
		if Input.is_action_just_pressed("Player_Sprint"):
			sprinting_toggle = !sprinting_toggle
			if sprinting_toggle:
				SPEED = 10.0
			else:
				SPEED = 5.0
			
		#shooting
		#AR = 0, Shotgun = 1, Pistol = 2
		if(Input.is_action_just_pressed("shoot")):
			animation_player.play("CharacterArmature|Run_Shoot")
			if ray_cast_3d.is_colliding():
				if (inventorySlot == 0):
					if (rifleRounds > 0):
						rifleRounds -= 1
						ar_shoot_audio.play()
						if (ray_cast_3d.get_collider() is Enemy):
							ray_cast_3d.get_collider().health -= 30
				elif (inventorySlot == 1):
					if (shotgunRounds > 0):
						shotgunRounds -= 1
						shotgun_shoot_audio.play()
						if (ray_cast_3d.get_collider() is Enemy):
							ray_cast_3d.get_collider().health -= 500/(self.global_position.distance_to(ray_cast_3d.get_collider().global_position))
				elif (inventorySlot == 2):
					if (pistolRounds > 0):
						pistolRounds -= 1
						pisto_shoot_audio.play()
						if (ray_cast_3d.get_collider() is Enemy):
							ray_cast_3d.get_collider().health -= 40
			
		
func _physics_process(delta: float) -> void:
	if GameManager.paused == false:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			if not walking_audio_stream.playing:
				walking_audio_stream.play()
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			if walking_audio_stream.playing:
				walking_audio_stream.stop()
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)


		rotate_camrea(delta)
		move_and_slide()


#for mouse move
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: 
		look_dir = event.relative * 0.01


#also mouse move
func rotate_camrea(delta: float, sense_mod: float = 1.0):
	if capMouse:
		var input = Input.get_vector("ui_left","ui_right","ui_down","ui_up")
		look_dir += input
		rotation.y -= look_dir.x * camra_sense * delta
		camera_3d.rotation.x = clamp(camera_3d.rotation.x - look_dir.y * camra_sense * sense_mod * delta,-1.5, 1.5)
		look_dir = Vector2.ZERO

func change_mouse()->void:
	capMouse = !capMouse
	if capMouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func take_damage_p(num:int)->void:
	health -= num
	ui.update_health(health)
	if health <= 0:
		ui.lose()
		change_mouse()
