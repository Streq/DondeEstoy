extends Node2D

func _ready():
	$actionable.connect("triggered", $remote_door, "trigger")
