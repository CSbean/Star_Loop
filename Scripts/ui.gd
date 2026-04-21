extends Control


var nearby : bool

const SHOTGUN_BG_REMOVE = preload("uid://c3m5nexfrrm82")
const AR_REMOVE_BG = preload("uid://68vculh1mfde")
const PISTIOLIMG_REMOVEBG_PREVIEW = preload("uid://cg00fy1425cuc")

@onready var timer_label: Label = $Timer/TimerLabel
@onready var pause_screen: Panel = $PauseScreen
@onready var health: Label = $Health
@onready var gun_text: TextureRect = $GunText
@onready var ammo_label: Label = $ammoLabel
@onready var keycard: Sprite2D = $Keycards/keycard
@onready var objective: Label = $PauseScreen/Objective
@onready var reload_audio: AudioStreamPlayer = $reloadAudio

var badPic = preload("res://Assets/Gun assets/pistiolimg-removebg-preview.png")
var greenPic = preload("res://Assets/keycard Images/mexico.png")
var redPic = preload("res://Assets/keycard Images/Redcardpic.png")
var whitePic = preload("res://Assets/keycard Images/whitePic.png")
var yellowPic = preload("res://Assets/keycard Images/yellowcardpic.png")

## 2 is pistol, 1 - shotgun, 0 - AK
var selectedGun := 2
var player : Player


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("esc")):
		pause_screen.visible = !pause_screen.visible
	timer_label.global_position.x = 528
	if (GameManager.keycardNum == 1):
		keycard.texture = whitePic
		objective.text = "Objective: Find Green Key card"
	elif (GameManager.keycardNum == 2):
		keycard.texture = greenPic
		objective.text = "Objective: Find Yellow Key card"
	elif (GameManager.keycardNum == 3):
		keycard.texture = yellowPic
		objective.text = "Objective: Find Red Key card"
	elif (GameManager.keycardNum == 4):
		keycard.texture = redPic
		objective.text = "Objective: Fix the ship's reactor"
	if(GameManager.keycardNum == 0):
		keycard.visible = false
	else:
		keycard.visible = true
	gun_text.visible = player.hasPistol
	ammo_label.visible = player.hasPistol
	if (Input.is_action_just_pressed("inventory up")):
		selectedGun +=1
		if (selectedGun >= 3):
			selectedGun = 2
		player.inventorySlot = selectedGun
	if (Input.is_action_just_pressed("inventory down")):
		selectedGun -=1
		if (selectedGun == 1) and !(player.hasShotgun):
			selectedGun +=1
		elif (selectedGun == 0) and !(player.hasRifle):
			selectedGun +=1
		else:
			reload_audio.play()
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

func _on_close_ui_pressed() -> void:
	pause_screen.visible = false
	GameManager.paused = false
	player.change_mouse()


func _on_main_menu_pressed() -> void:
	GameManager.paused = false
	GameManager.change_map(1)
