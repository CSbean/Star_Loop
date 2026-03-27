extends Control

"res://Assets/pistiolimg-removebg-preview.png"
var badPic = preload("res://Assets/pistiolimg.png")


@onready var health: Label = $Health
@onready var texture_rect: TextureRect = $TextureRect


func update_health(num:int)->void:
	health.text = str(num)

func lose()->void:
	GameManager.paused = true

func invChange(num:int)->void:
	if num == 2:
		texture_rect.texture = badPic
