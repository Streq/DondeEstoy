extends Node


var creature


# Called when the node enters the scene tree for the first time.
func _ready():
	$lever.connect("on", self, "trigger")
	creature = $giant_creature
	remove_child(creature)
	
func trigger():
	add_child(creature)
