extends Node

export (PackedScene) var scene

# Called when the node enters the scene tree for the first time.
func _ready():
	$scene_manager.push(scene.instance())
