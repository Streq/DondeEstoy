extends Control


var scenes = []

var _current = null

var tasks = []

func _ready():
	Signals.connect("push_scene",self,"_push")
	Signals.connect("pop_scene",self,"_pop")
	Signals.connect("clear_scene",self,"_clear")

func _push(scene):
	tasks.push_back(["push",scene])

func _pop():
	tasks.push_back(["pop"])

func _clear():
	tasks.push_back(["pop"])


func push(scene):
	scenes.push_back(scene)

func pop():
	scenes.pop_back().queue_free()

func clear():
	for scene in scenes:
		scene.queue_free()
	_current = null
	scenes = []

func _physics_process(delta):
	if !tasks.empty():
		while !tasks.empty():
			var task = tasks.pop_back()
			match task[0]:
				"push":
					push(task[1])
				"pop":
					pop()
				"clear":
					clear()
		if !scenes.empty():
			call_deferred("_activate", scenes.back())


func _activate(scene):
	if _current:
		remove_child(_current)
	_current = scene
	add_child(_current)
