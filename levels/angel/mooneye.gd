extends Node2D

export(int, LAYERS_2D_PHYSICS) var visibility_layers := 0
var look_for_player := false

var player = null

func _on_body_entered(body):
	if body.is_in_group("player"):
		look_for_player=true
		player = body
		
		
func _physics_process(delta):
	if look_for_player:
		var target = player.get_pov().get_origin()
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, target, [], visibility_layers)
		if result.has("collider") and result.collider == player:
			$eye.look(target)


func _on_body_exited(body):
	if body.is_in_group("player"):
		look_for_player = false
