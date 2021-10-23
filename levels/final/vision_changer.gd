extends Node


func _on_to_dreamland_area_entered(area):
	var p : Player = get_tree().get_nodes_in_group("player")[0]
	p.blindspot.visible = false


func _on_to_world_area_entered(area):
	var p : Player = get_tree().get_nodes_in_group("player")[0]
#	p.blindspot.visible = true
