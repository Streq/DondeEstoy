extends Line2D

export (PackedScene) var world

var world_instance

const colors := PoolColorArray([Color.white,Color.white,Color.white])
onready var polygon := PoolVector2Array([Vector2.ZERO, self.points[0], self.points[1]])
onready var render_polygon = $render_polygon

onready var pov = $view/pov

var player = null

var i = 0

func _ready():
	world_instance = world.instance()
	$view.add_child(world_instance)
	
func _process(delta):
	if player:
		pov.global_transform = player.get_pov()
		polygon[0] = to_local(pov.global_position).floor()
		render_polygon.polygon[0] = polygon[1].floor()
		render_polygon.polygon[1] = polygon[2].floor()
		render_polygon.polygon[2] = (polygon[2] + polygon[0].direction_to(polygon[2])*64000).floor()
		render_polygon.polygon[3] = (polygon[1] + polygon[0].direction_to(polygon[1])*64000).floor()
		
		render_polygon.uv = global_transform.xform(render_polygon.polygon)
	

func _on_cull_body_shape_entered(body_id, body, body_shape, local_shape):
#	print_debug(i,", body_id: ", body_id, ", body: ", body, ", body_shape: ", body_shape,", local_shape: ", local_shape)
	pass


func _on_cull_body_entered(body):
	pass # Replace with function body.
