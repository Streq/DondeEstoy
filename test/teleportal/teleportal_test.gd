extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	var tree = get_tree()
	var player = tree.get_nodes_in_group("player")[0]
	var povs = tree.get_nodes_in_group("pov")
	
	for pov in povs:
		pov.global_position = player.get_pov()
