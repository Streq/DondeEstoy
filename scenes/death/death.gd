extends Node2D
signal retry()

var retry = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if !Globals.died_once: 
		yield(get_tree().create_timer(1.0),"timeout")
	Globals.died_once = true
	retry = true
	$retry.visible = true
	
func _input(event):
	if retry and event.is_action_pressed("A"):
		Signals.emit_signal("pop_scene")
