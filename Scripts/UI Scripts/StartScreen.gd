extends Control
@onready var settings_menu: Panel = $SettingsMenu
@onready var credits_menu: Panel = $CreditsMenu
@onready var main_menu: Panel = $MainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_quit_pressed() -> void:
	get_tree().quit()
func _on_start_pressed() -> void:
	GameManager.change_map(0)
func _on_settings_pressed() -> void:
	settings_menu.visible = true
	main_menu.visible = false
func _on_open_credits_pressed() -> void:
	settings_menu.visible = false
	credits_menu.visible = true
func _on_close_credits_pressed() -> void:
	credits_menu.visible = false
	main_menu.visible = true
func _on_close_settings_pressed() -> void:
	settings_menu.visible = false
	main_menu.visible = true
