extends Control

var badPic = preload("res://Assets/Gun assets/pistiolimg-removebg-preview.png")
var nearby : bool
const SHOTGUN_BG_REMOVE = preload("uid://c3m5nexfrrm82")
const AR_REMOVE_BG = preload("uid://68vculh1mfde")
const PISTIOLIMG_REMOVEBG_PREVIEW = preload("uid://cg00fy1425cuc")
@onready var timer_label: Label = $Timer/TimerLabel

var greenPic = preload("res://Assets/keycard Images/mexico.png")
var redPic = preload("res://Assets/keycard Images/Redcardpic.png")
var whitePic = preload("res://Assets/keycard Images/whitePic.png")
var yellowPic = preload("res://Assets/keycard Images/yellowcardpic.png")
@onready var keycard: Sprite2D = $Keycards/keycard
## 0 is pistol, 1 - shotgun, 2 - AK
var selectedGun := 0
@onready var health: Label = $Health
@onready var gun_text: TextureRect = $GunText
@onready var ammo_label: Label = $ammoLabel
var player : Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta: float) -> void:
	timer_label.global_position.x = 528
	if (GameManager.keycardNum == 1):
		keycard.texture = whitePic
	elif (GameManager.keycardNum == 2):
		keycard.texture = greenPic
	elif (GameManager.keycardNum == 3):
		keycard.texture = yellowPic
	elif (GameManager.keycardNum == 4):
		keycard.texture = redPic
	if (Input.is_action_just_pressed("inventory up")):
		selectedGun +=1
		if (selectedGun >= 3):
			selectedGun = 2
		player.inventorySlot = selectedGun
	if (Input.is_action_just_pressed("inventory down")):
		selectedGun -=1
		if (selectedGun <= -1):
			selectedGun = 0
		player.inventorySlot = selectedGun
	if (selectedGun == 2):
		gun_text.texture = PISTIOLIMG_REMOVEBG_PREVIEW
		ammo_label.text = str(player.pistolRounds)
	elif (selectedGun == 1):
		gun_text.texture = SHOTGUN_BG_REMOVE
		ammo_label.text = str(player.shotgunRounds)
	elif (selectedGun ==0):
		gun_text.texture = AR_REMOVE_BG
		ammo_label.text = str(player.rifleRounds)
func update_health(num:int)->void:
	health.text = str(num)

func lose()->void:
	GameManager.paused = true
