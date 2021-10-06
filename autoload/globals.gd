extends Node

const DISPLAY_WIDTH:int = 640
const DISPLAY_HEIGHT:int = 320


var died_once := false

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
