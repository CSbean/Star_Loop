extends Node

var paused :bool = false
var keycardNum = 0

#credits
# Astronaut by Quaternius
# Scifi Pistol by Quaternius
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
#
##Method 1: Automatic Generation (Editor)
#Select your MeshInstance3D node in the Scene tree.
#In the 3D viewport toolbar, click the Mesh button.
#Choose Create Trimesh Static Sibling for complex, accurate collisions (like terrain).
#Choose Create Convex Static Sibling for simpler, high-performance collisions (like boxes or walls).
#Result: Godot automatically creates a StaticBody3D with a CollisionShape3D as a sibling node.
#
