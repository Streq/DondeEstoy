extends Area2D


export (Vector2) var offset


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_portal_body_entered(body):
	if body.is_in_group("player"):
		body.position += offset
		get_node("../Camera2D").offset += offset
