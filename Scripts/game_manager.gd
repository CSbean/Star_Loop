extends Node

var paused :bool = false
var keycardNum = 0
var player : Player
var newMap : PackedScene
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func change_map(levelCode : int) -> void:
	if (levelCode == 0):
		newMap = load("res://Scenes/main_scene.tscn")
		
	elif (levelCode == 1):
		newMap = load("res://Scenes/UI Scenes/StartScreen.tscn")
	
	get_tree().change_scene_to_packed(newMap)





























###credits
#Ship Assets by Quaternius
#Astronaut by Quaternius
#Scifi Pistol by Quaternius
#Sci-Fi Shotgun by burunduk [CC-BY] via Poly Pizza
#Alien by Quaternius
#Cockpit control center by Poly by Google [CC-BY]
#Ceiling Light by Ryan Donaldson [CC-BY]
#Pickup Key Card by Quaternius
#Pickup Health by Quaternius
#Bullets Pickup by Quaternius
#Coil Gun by Vas Pupin [CC-BY] via Poly Pizza
#Space engine by Poly by Google [CC-BY] via Poly Pizza
#Sci Fi Engine by Dipper98
#Ammo Shotgun by CreativeTrio
#Ammo Sniper by CreativeTrio
#
#
