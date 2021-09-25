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
