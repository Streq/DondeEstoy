extends Sprite

onready var messages = [$hola0, $hola1, $hola2, $hola3]
var done = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and !done:
		done = true
		for message in messages: 
			message.visible = true
			yield(get_tree().create_timer(3.0),"timeout")
			message.visible = false
		$hola4.visible=true
		get_tree().get_nodes_in_group("player")[0].pause = true
		get_tree().get_nodes_in_group("player")[0].get_node("AnimationPlayer").stop(false)
