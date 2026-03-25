extends CharacterBody3D
class_name Player

@onready var camera_3d: Camera3D = $Camera3D
@onready var animation_player: AnimationPlayer = $PlayerSprite/AnimationPlayer
@onready var scifi_pistol: Node3D = $PlayerSprite/RootNode/CharacterArmature/Skeleton3D/BoneAttachment3D/ScifiPistol
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var spot_light_3d: SpotLight3D = $Camera3D/SpotLight3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5

#camra var's
var look_dir: Vector2
var camra_sense := 50
var capMouse := false
var flashOn := false
var sprinting_toggle = false
var pistolVisabilityToggle = false
var health = 100

func _ready() -> void:
	change_mouse()

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Flashlight")):
		flashOn = !flashOn
		spot_light_3d.visible = flashOn
	if (Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()
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
			



		#if animation_player.current_animation == "CharacterArmature|Gun_Shoot" or animation_player.current_animation == "CharacterArmature|Run_Shoot":
			#pistolVisabilityToggle = true
		#else:
			#pistolVisabilityToggle = false
		
		
		
		# animations
		if sprinting_toggle and Input.is_action_pressed("shoot"):
			animation_player.play("CharacterArmature|Run_Shoot")
			if ray_cast_3d.is_colliding():
				if ray_cast_3d.get_collider() is Enemy:
					ray_cast_3d.get_collider().queue_free()
		elif sprinting_toggle == false and Input.is_action_pressed("shoot"):
			animation_player.play("CharacterArmature|Gun_Shoot")
			if ray_cast_3d.is_colliding():
				if ray_cast_3d.get_collider() is Enemy:
					ray_cast_3d.get_collider().queue_free()
		
		#walking foward
		elif sprinting_toggle and Input.is_action_pressed("move_forward"):
			animation_player.play("CharacterArmature|Run")
		elif sprinting_toggle == false and Input.is_action_pressed("move_forward"):
			animation_player.play("CharacterArmature|Walk")
		#walking backwards
		elif Input.is_action_pressed("move_back"):
			animation_player.play("CharacterArmature|Run_Back")
		#walking right
		elif Input.is_action_pressed("move_right"):
			animation_player.play("CharacterArmature|Run_Right")
		#walking left
		elif Input.is_action_pressed("move_left"):
			animation_player.play("CharacterArmature|Run_Left")
			
		#if Input.is_action_pressed("shoot"):
		#	animation_player.play("CharacterArmature|Gun_Shoot")
		
		
		else:
			animation_player.play("CharacterArmature|Idle")
		
		
		

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
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
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
