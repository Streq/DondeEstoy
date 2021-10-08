extends Node2D

var targets = []
var target = null

func _physics_process(delta):
	if target:
		$left_eye.look(target.global_position)
		$right_eye.look(target.global_position)
		$hand/position.global_position = target.global_position + target.velocity * delta * delta * 5
		
		if !$hand/AnimationPlayer.is_playing():
			$hand/AnimationPlayer.play("grab")
	else:
		if $hand/AnimationPlayer.is_playing() and $hand/AnimationPlayer.current_animation == "grab":
			$hand/AnimationPlayer.play("hide")
			

func _on_vision_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("monster"):
		targets.push_back(body)
		update_target()

func _on_vision_body_exited(body):
	targets.remove(targets.find(body))
	update_target()
	
func update_target():
	if targets.size():
		target = targets[0]
	else:
		target = null
