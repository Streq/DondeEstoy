extends Area2D

onready var monster = $monster

func _ready():
	remove_child(monster)


func _on_body_entered(body):
	if body.is_in_group("player"):
		add_child(monster)
		monitoring = false
