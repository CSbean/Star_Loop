extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var paused :bool = false
var keycardNum = 0
var pshoot = "res://Assets/SFX & VFX/sfx/ray-gun-a-10-a.mp3" #does not work 
var p 

func _ready() -> void:
	p = get_tree().get_first_node_in_group("Player")



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



func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("shoot")) and p.inventorySlot == 2:
		audio_stream_player.play(pshoot)












#
##Method 1: Automatic Generation (Editor)
#Select your MeshInstance3D node in the Scene tree.
#In the 3D viewport toolbar, click the Mesh button.
#Choose Create Trimesh Static Sibling for complex, accurate collisions (like terrain).
#Choose Create Convex Static Sibling for simpler, high-performance collisions (like boxes or walls).
#Result: Godot automatically creates a StaticBody3D with a CollisionShape3D as a sibling node.
#
