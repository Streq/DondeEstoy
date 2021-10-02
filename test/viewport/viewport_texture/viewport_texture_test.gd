extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#this fucks everythang up (cause the viewport is rendering within itself)
	$"1/vp".texture=get_viewport().get_texture()
	pass


func _physics_process(delta):
	$"1/vp".set_position(get_global_mouse_position())
