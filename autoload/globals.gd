extends Node

const DISPLAY_WIDTH:int = 640
const DISPLAY_HEIGHT:int = 320

var can_restart := OS.is_debug_build()
var died_once := false

func _input(event):
	if event.is_action_pressed("restart") and can_restart:
		get_tree().reload_current_scene()
