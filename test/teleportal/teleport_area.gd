extends Area2D

export (NodePath) var world1:NodePath
export (NodePath) var world2:NodePath
onready var w1 = get_node(world1)
onready var w2 = get_node(world2)

func _on_body_entered(body):
	var parent1 = w1.get_parent()
	parent1.remove_child(w1)
	var parent2 = w2.get_parent()
	parent2.remove_child(w2)
	
	parent1.add_child(w2)
	parent2.add_child(w1)
	
	
	
