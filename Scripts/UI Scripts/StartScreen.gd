extends Control
@onready var settings_menu: Panel = $SettingsMenu
@onready var credits_menu: Panel = $CreditsMenu
@onready var main_menu: Panel = $MainMenu
@onready var start_audio: AudioStreamPlayer = $startAudio
@onready var credits_audio: AudioStreamPlayer = $creditsAudio
@onready var how_to_play_menu: Panel = $howToPlayMenu
@onready var sense_slider: HSlider = $SettingsMenu/SenseSlider
@onready var sprint_toggle: CheckButton = $SettingsMenu/SprintToggle
@onready var audio_check: CheckButton = $SettingsMenu/AudioCheck
@onready var dev_mode: CheckButton = $SettingsMenu/DevMode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprint_toggle.button_pressed = GameManager.sprintToggleModeOn
	sense_slider.value = GameManager.setSensitivity
	audio_check.button_pressed = GameManager.playAudio
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("quit")):
		get_tree().quit()
	elif (Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()
		
func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_start_pressed() -> void:
	GameManager.dev_mode_avail = dev_mode.button_pressed
	GameManager.playAudio = audio_check.button_pressed
	GameManager.sprintToggleModeOn = sprint_toggle.button_pressed
	GameManager.setSensitivity = int(sense_slider.value)
	GameManager.change_map(0)
func _on_settings_pressed() -> void:
	settings_menu.visible = true
	main_menu.visible = false
func _on_open_credits_pressed() -> void:
	settings_menu.visible = false
	credits_menu.visible = true
	#stop
	start_audio.stop()
	#start
	credits_audio.play()
func _on_close_credits_pressed() -> void:
	credits_menu.visible = false
	main_menu.visible = true
	#start
	start_audio.play()
	#stop
	credits_audio.stop()
func _on_close_settings_pressed() -> void:
	settings_menu.visible = false
	main_menu.visible = true
func _on_how_to_play_pressed() -> void:
	settings_menu.visible = false
	how_to_play_menu.visible = true
func _on_close_how_to_play_pressed() -> void:
	how_to_play_menu.visible = false
	settings_menu.visible = true
