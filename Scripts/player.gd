extends CharacterBody3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var animation_player: AnimationPlayer = $PlayerSprite/AnimationPlayer


var SPEED = 5.0
const JUMP_VELOCITY = 4.5

#camra var's
var look_dir: Vector2
var camra_sense := 50
var capMouse := false

var sprinting_toggle = false

func _ready() -> void:
	change_mouse()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		change_mouse()
	
	if Input.is_action_just_pressed("Player_Sprint"):
		sprinting_toggle = !sprinting_toggle
		SPEED = 10
	
	if sprinting_toggle and Input.is_action_pressed("move_forward"):
		animation_player.play("CharacterArmature|Run")
		
	elif sprinting_toggle == false and Input.is_action_pressed("move_forward"):
		animation_player.play("CharacterArmature|Walk")
	else:
		animation_player.play("CharacterArmature|Idle")
	
	
	

func _physics_process(delta: float) -> void:
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
