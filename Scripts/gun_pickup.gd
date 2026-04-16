extends Area3D
##Pistol = 2, Shotgun = 1, AR = 0
@export var type : int
@onready var rifle_asset: Node3D = $RifleAsset
@onready var pistol_asset: Node3D = $PistolAsset
@onready var shotgun_asset: Node3D = $ShotgunAsset
var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (type == 2):
		pistol_asset.visible = true
	elif (type == 1):
		shotgun_asset.visible = true
	elif (type == 0):
		rifle_asset.visible = true


func _on_body_entered(body: Node3D) -> void:
	if (body is Player):
		player = body
		if (type == 0):
			player.hasRifle = true
		elif (type == 1):
			player.hasShotgun = true
		elif (type == 2):
			player.hasPistol = true
		self.queue_free()
