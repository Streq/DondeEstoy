extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	var tree = get_tree()
	var player = tree.get_nodes_in_group("player")[0]
	$portal.player = player
	
#	player.position = get_global_mouse_position()
#	player.velocity = Vector2.ZERO
#	player.get_node("Sprite/sight/blindspot").visible = false
