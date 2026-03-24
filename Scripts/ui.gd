extends Control


@onready var health: Label = $Health


func update_health(num:int)->void:
	health.text = str(num)
