extends Node2D


var target = null

func _physics_process(delta):
	if target:
		$left_eye.look(target.global_position)
		$right_eye.look(target.global_position)
		$hand.position = to_local(target.global_position)
		if !$hand/AnimationPlayer.is_playing():
			$hand/AnimationPlayer.play("grab")

func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		target = body


func _on_vision_body_exited(body):
	if body == target:
		target = null
