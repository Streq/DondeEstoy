tool
extends Position2D

export (bool) var move_in_editor:=true


func _process(delta):
	if move_in_editor or !Engine.editor_hint:
		position = get_global_mouse_position()
		update()
