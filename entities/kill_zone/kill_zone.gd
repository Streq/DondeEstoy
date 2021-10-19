extends Area2D

export (PoolStringArray) var targets

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	for x in targets:
		if body.is_in_group(x):
			body.die()
			break
