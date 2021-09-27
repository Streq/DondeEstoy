extends Control


var scenes = []

var _current = null

func _ready():
	Signals.connect("push_scene",self,"push")
	Signals.connect("pop_scene",self,"pop")
	Signals.connect("clear_scene",self,"clear")

func push(scene):
	scenes.push_back(scene)
	call_deferred("_activate",scene)

func pop():
	scenes.pop_back().queue_free()
	call_deferred("_activate",scenes.back())

func clear():
	for scene in scenes:
		scene.queue_free()
	_current = null
	scenes = []

func _activate(scene):
	if _current:
		remove_child(_current)
	_current = scene
	add_child(_current)
