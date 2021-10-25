extends Node

const DISPLAY_WIDTH:int = 640
const DISPLAY_HEIGHT:int = 320

var died_once := false
onready var debug := OS.is_debug_build()
onready var can_restart := debug

func _input(event):
	if event.is_action_pressed("restart") and can_restart:
		get_tree().reload_current_scene()
