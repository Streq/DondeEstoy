extends Line2D

export (NodePath) var pov_path
export (NodePath) var player_path


const colors := PoolColorArray([Color.white,Color.white,Color.white])
onready var polygon := PoolVector2Array([Vector2.ZERO, self.points[0], self.points[1]])
onready var render_polygon = $render_polygon


onready var pov = get_node(pov_path)

onready var player = get_node(player_path)

var i = 0

	
func _process(delta):
	if player:
		pov.global_transform = player.get_pov()
		var local = to_local(pov.global_position)
		polygon[0] = local#Vector2(floor(local.x),floor(local.y))
		render_polygon.polygon[0] = polygon[1]
		render_polygon.polygon[1] = polygon[2]
		render_polygon.polygon[2] = polygon[2] + polygon[0].direction_to(polygon[2])*64000
		render_polygon.polygon[3] = polygon[1] + polygon[0].direction_to(polygon[1])*64000
		
		render_polygon.uv = global_transform.xform(render_polygon.polygon)
	

func _on_cull_body_shape_entered(body_id, body, body_shape, local_shape):
#	print_debug(i,", body_id: ", body_id, ", body: ", body, ", body_shape: ", body_shape,", local_shape: ", local_shape)
	pass


func _on_cull_body_entered(body):
	pass # Replace with function body.
