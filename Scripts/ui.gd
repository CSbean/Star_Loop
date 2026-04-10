extends Control

var badPic = preload("res://Assets/pistiolimg-removebg-preview.png")
var nearby : bool
const SCREENSHOT_2026_04_210_123409 = preload("uid://bg0yqyaoj3025")
const PISTIOLIMG_REMOVEBG_PREVIEW = preload("uid://cg00fy1425cuc")

var greenPic = preload("res://Assets/keycard Images/mexico.png")
var redPic = preload("res://Assets/keycard Images/Redcardpic.png")
var whitePic = preload("res://Assets/keycard Images/whitePic.png")
var yellowPic = preload("res://Assets/keycard Images/yellowcardpic.png")
@onready var keycard: Sprite2D = $Keycards/keycard
## 0 is pistol, 1 - shotgun, 2 - AK
var selectedGun := 0
@onready var health: Label = $Health
@onready var gun_text: TextureRect = $GunText


func _process(_delta: float) -> void:
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
			selectedGun = 0
	if (Input.is_action_just_pressed("inventory down")):
		selectedGun -=1
		if (selectedGun <= -1):
			selectedGun = 2
	if (selectedGun == 0):
		gun_text.texture = PISTIOLIMG_REMOVEBG_PREVIEW
func update_health(num:int)->void:
	health.text = str(num)

func lose()->void:
	GameManager.paused = true
