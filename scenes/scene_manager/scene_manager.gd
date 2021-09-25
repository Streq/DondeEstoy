extends Control


var scenes = []

var _current = null

func push(scene):
	scenes.push_back(scene)
	_activate(scene)

func pop():
	scenes.pop_back().queue_free()
	_activate(scenes.back())

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
