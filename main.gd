extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$root.main_vp_width = Globals.DISPLAY_WIDTH
	$root.main_vp_height = Globals.DISPLAY_HEIGHT
	$root.reset()
	Signals.emit_signal("push_scene", Scenes.game.instance())


func _input(event):
	if OS.is_debug_build():
		if event.is_action_pressed("next_level"):
			Signals.emit_signal("next_level")
		if event.is_action_pressed("kill"):
			Signals.emit_signal("death")
