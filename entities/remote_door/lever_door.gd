extends Node2D

func _ready():
	$lever.connect("on",$remote_door,"open")
	$lever.connect("off",$remote_door,"close")
