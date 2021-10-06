extends Node2D

export (NodePath) var player_path

onready var occ_w1 = $occluder_w1
onready var occ_w2 = $occluder_w2

onready var w2_parent = $world_container/world

onready var area = $center/entrance/Area2D


func _ready():
	$center/entrance.pov = $world_container/pov
	$center/entrance.player = get_node(player_path)
	occ_w2.visible = false

func _on_area_entered(area):
	if area.is_in_group("player_pov"):
		call_deferred("teleport")
		
#		area.connect("area_entered", self, "_on_area_entered")

func set_world_to(world):
	if w2_parent.get_child_count()>0:
		w2_parent.remove_child(w2_parent.get_child(0))
	w2_parent.add_child(world)

func teleport():
	$center.transform.x *= -1.0	
	var w1 = get_parent()
	var w1_parent = w1.get_parent()
	
	var w2 = w2_parent.get_child(0)
	
	w1.remove_child(self)
	w2.add_child(self)
	
	w1_parent.remove_child(w1)
	w2_parent.remove_child(w2)
	
	w1_parent.add_child(w2)
	w2_parent.add_child(w1)
	

	occ_w1.visible = !occ_w1.visible
	occ_w2.visible = !occ_w2.visible
		
