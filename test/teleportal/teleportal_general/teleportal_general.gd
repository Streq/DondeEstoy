extends Node2D


export (PackedScene) var scene_portal


# Called when the node enters the scene tree for the first time.
func _ready():
	$world/portal.set_world_to(scene_portal.instance())
