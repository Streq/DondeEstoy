extends Node2D

export (NodePath) var player_path
export (NodePath) var world_vp_path

onready var occ_w1 = $center/entrance/occluder
onready var occ_w2 = $center/entrance2/occluder

onready var area = $center/entrance/Area2D

onready var w1 = get_parent()
onready var w2 = null

onready var current_w = w1
onready var current_w2 = w2

onready var entrance := $center/entrance
onready var entrance2 := $center/entrance2

func _ready():
	set_world_to(get_node(world_vp_path))
	
	entrance.player = get_node(player_path)
#	occ_w2.visible = false
	entrance.src_world = w1
	entrance.des_world = w2
	
	entrance2.player = get_node(player_path)

	entrance2.src_world = w2
	entrance2.des_world = w1
	
	

func _on_area_entered(area):
	if area.is_in_group("player_pov"):
		call_deferred("teleport_player")
#		area.connect("area_entered", self, "_on_area_entered")

func _on_body_entered(body):
	if body.is_in_group("monster"):
		call_deferred("teleport",body)
		
func set_world_to(world_vp):
	w2 = world_vp.get_node("world")
	entrance.pov = world_vp.get_node("pov")
	entrance2.pov = world_vp.get_node("pov")
	
	entrance.render_polygon.texture = world_vp.get_texture()
	entrance2.render_polygon.texture = world_vp.get_texture()
	
	var t = entrance2.global_transform
	entrance2.get_parent().remove_child(entrance2)
	w2.add_child(entrance2)
	entrance2.global_transform = t
	
func teleport_player():
#	$center.transform.x *= -1.0	
	
	var w1_parent = w1.get_parent()
	var w2_parent = w2.get_parent()
	
#	current_w.remove_child(self)
#	current_w2.add_child(self)
	
	var aux_w = current_w
	current_w = current_w2
	current_w2 = aux_w
	
	w1_parent.remove_child(w1)
	w2_parent.remove_child(w2)
	
	w1_parent.add_child(w2)
	w2_parent.add_child(w1)
	

#	occ_w1.visible = !occ_w1.visible
#	occ_w2.visible = !occ_w2.visible
