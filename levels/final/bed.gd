extends Node2D

var player = null
var done = false
var replay = false

func _on_actionable_triggered():
	if !done:
		$sprite_occupied.visible = true
		$sprite_empty.visible = false
		$actionable.visible = false
		if player:
			player.disappear(true)
		yield(get_tree().create_timer(2.0),"timeout")
		$actionable/interact_message.message = "Fin."
		$actionable.visible = true
		done = true
		
		yield(get_tree().create_timer(2.0),"timeout")
#		$credits_message.visible = true
		
		yield(get_tree().create_timer(1.0),"timeout")
#		$restart_message.visible = true
		Globals.can_restart = true


func _on_actionable_body_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_actionable_body_exited(body):
	if body.is_in_group("player"):
		player = null
