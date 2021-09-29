extends Line2D


var pov = null
const colors := PoolColorArray([Color.white,Color.white,Color.white])
onready var polygon := PoolVector2Array([Vector2.ZERO, self.points[0], self.points[1]])
onready var render_polygon = $render_polygon
var i = 0

func _ready():
	var tree = get_tree()
	if tree.has_group("pov"):
		pov = tree.get_nodes_in_group("pov")[0]
	$cull/CollisionPolygon2D.polygon = polygon


func _process(delta):
	polygon[0] = pov.global_position
	$cull/CollisionPolygon2D.polygon[0] = polygon[0]
	render_polygon.polygon[0] = polygon[1]
	render_polygon.polygon[1] = polygon[2]
	render_polygon.polygon[2] = polygon[2] + polygon[0].direction_to(polygon[2])*64000
	render_polygon.polygon[3] = polygon[1] + polygon[0].direction_to(polygon[1])*64000
	

	

func _on_cull_body_shape_entered(body_id, body, body_shape, local_shape):
	i += 1 
	print_debug(i)

#	print_debug(i,", body_id: ", body_id, ", body: ", body, ", body_shape: ", body_shape,", local_shape: ", local_shape)



func _on_cull_body_entered(body):
	pass # Replace with function body.
