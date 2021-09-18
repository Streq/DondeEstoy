tool
extends Position2D


func _process(delta):
	position = get_global_mouse_position()
	update()
