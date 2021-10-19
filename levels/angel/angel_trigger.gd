extends Node

var child

func _ready():
	$lever.connect("on", self, "trigger")
	child = $child
	remove_child(child)
	
func trigger():
	add_child(child)
	pass
