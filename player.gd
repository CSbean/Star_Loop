extends CharacterBody3D

@onready var camera_3d: Camera3D = $Camera3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var look_dir: Vector2
var camra_sense := 50

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func rotate_camrea(delta: float, sense_mod: float = 1.0):
	var input = Input.get_vector("ui_left","ui_right","ui_down","ui_up")
	look_dir += input
	rotation.y -= look_dir.x * camra_sense * delta
	camera_3d.rotation.x = clamp(camera_3d.rotation.x - look_dir.y * camra_sense * sense_mod * delta,-1.5, 1.5)
	look_dir = Vector2.ZERO
