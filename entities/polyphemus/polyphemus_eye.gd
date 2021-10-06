extends Node2D

const max_eye_movement = 5.0

func _physics_process(delta):
	var players = get_tree().get_nodes_in_group("player")
	if players.size():
		var player = players[0] 
		if player.get_node("AnimationPlayer").current_animation == "run":
			hear_noise(player.global_position)

func hear_noise(noise_position):
	var direction = global_position.direction_to(noise_position)
	$pupil.position = direction * min (max_eye_movement, 5.0)
