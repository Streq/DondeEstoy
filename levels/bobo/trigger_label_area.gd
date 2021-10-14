extends Area2D

func _ready():
	visible = false


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		visible = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		visible = false
