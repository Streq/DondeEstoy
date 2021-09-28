extends Sprite


func _physics_process(delta):
#	position = get_global_mouse_position()
	pass

func _input(event):
	if event is InputEventMouseButton:
		position = get_global_mouse_position()
