extends Node2D


"""
Los portales:
	mueven al jugador
	mueven la camara
	dejan ver el destino
		para dejar verlo tienen que:
			tener un viewport al destino
"""
func _ready():
	$portal/view.world_2d = get_world_2d()

func _teleport_to(body, distance, world):
	body.global_position += distance
	get_tree().get_nodes_in_group("view")[0].offset += distance

func _on_0_body_entered(body):
	_teleport_to(body, $"1".global_position-$"0".global_position, $"1".get_world_2d())
	$portal.position = $"1".position

func _on_1_body_entered(body):
	_teleport_to(body, $"0".global_position-$"1".global_position, $"0".get_world_2d())
	$portal.position = $"0".position

