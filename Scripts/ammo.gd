extends Area3D
## 1 = medkit, 2 = pistol ammo, 3 = rifle ammo, 4 = shotgun ammo
@export var type : int = 0
## pistol = 6, shotgun = 3, rifle = 12
@export var amount : int
@onready var medkit: Node3D = $Medkit
@onready var pistol_ammo: Node3D = $PistolAmmo
@onready var rifle_ammo: Node3D = $RifleAmmo
@onready var shotgun_ammo: Node3D = $ShotgunAmmo
@onready var propmt: Label3D = $propmt

var isNearby := false
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
func _process(_delta: float) -> void:
	if (isNearby && Input.is_action_just_pressed("interact")):
		if (type == 1):
			if (player.health < 100):
				player.health +=amount
				if (player.health >= 100):
					player.health = 100
			player.ui.update_health(player.health)
		if (type == 2):
			player.pistolRounds += amount
		if (type == 3):
			player.rifleRounds += amount
		if (type == 4):
			player.shotgunRounds += amount
		self.queue_free()


func _on_body_entered(body: Node3D) -> void:
	if (body is Player):
		propmt.visible = true
		isNearby = true
		

func _on_body_exited(body: Node3D) -> void:
	if (body is Player):
		propmt.visible = false
		isNearby = false
