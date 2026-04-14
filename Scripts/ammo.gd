extends Area3D
@export var type : int = 0
@onready var medkit: Node3D = $Medkit
@onready var pistol_ammo: Node3D = $PistolAmmo
@onready var rifle_ammo: Node3D = $RifleAmmo
@onready var shotgun_ammo: Node3D = $ShotgunAmmo
var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if (type == 1):
		medkit.visible = true 
	if (type == 2):
		pistol_ammo.visible = true 
	if (type == 3):
		rifle_ammo.visible = true 
	if (type == 4):
		shotgun_ammo.visible = true 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if (body is Player):
		if (type == 1):
			player.health +=25
		if (type == 2):
			player.pistolRounds += 6
		if (type == 3):
			player.rifleRounds += 12
		if (type == 4):
			player.shotgunRounds += 3
		self.queue_free()
