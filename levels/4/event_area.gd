extends Area2D

onready var monster = $monster

func _ready():
	call_deferred("remove_child", monster)


func _on_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("add_child", monster)
		set_deferred("monitoring", false)
