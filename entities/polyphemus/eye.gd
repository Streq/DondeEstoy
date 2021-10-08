extends Node2D

const max_eye_movement = 5.0

func look(position):
	var direction = global_position.direction_to(position)
	$pupil.position = direction * min (max_eye_movement, 5.0)
