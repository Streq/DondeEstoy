extends Node

export (PackedScene) var scene

# Called when the node enters the scene tree for the first time.
func _ready():
	$scene_manager.push(scene.instance())

var pause:bool = false

func _input(event):
	if event.is_action_pressed("B"):
		if !pause:
			$scene_manager.push(Scenes.death.instance())
		else:
			$scene_manager.pop()
		pause = !pause
