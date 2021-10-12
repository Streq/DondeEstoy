extends Line2D


onready var polygon := PoolVector2Array([Vector2.ZERO, self.points[0], self.points[1]])
onready var render_polygon := $render_polygon

var pov
var player

var i = 0

var src_world
var des_world

export (int, -1, 1, 2) var orientation := 1
	
func _process(delta):
	if player:
		pov.global_transform = player.get_pov()
		if to_local(pov.global_position).x*orientation < 0:
			visible = false
		else:
			visible = true
			polygon[0] = to_local(pov.global_position)
			render_polygon.polygon[0] = polygon[1]
			render_polygon.polygon[1] = polygon[2]
			render_polygon.polygon[2] = (polygon[2] + polygon[0].direction_to(polygon[2])*6400)
			render_polygon.polygon[3] = (polygon[1] + polygon[0].direction_to(polygon[1])*6400)
			
			render_polygon.uv = global_transform.xform(render_polygon.polygon)


func _on_body_entered(body):
	if body.is_in_group("monster"):
		call_deferred("teleport",body)

func teleport(body):
	var t = body.global_transform
	src_world.remove_child(body)
	des_world.add_child(body)
	body.global_transform = t
