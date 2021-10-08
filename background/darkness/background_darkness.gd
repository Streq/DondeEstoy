tool
extends Node2D

func _ready():
	for child in get_children():
		child.z_index = -int(child.name)
		child.get_node("shadow").light_mask = 0
