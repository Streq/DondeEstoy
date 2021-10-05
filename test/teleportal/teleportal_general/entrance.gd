extends Line2D

export (NodePath) var player_path


const colors := PoolColorArray([Color.white,Color.white,Color.white])
onready var polygon := PoolVector2Array([Vector2.ZERO, self.points[0], self.points[1]])
onready var render_polygon = $render_polygon

var pov
var player

var i = 0

	
func _process(delta):
	if player:
		pov.global_transform = player.get_pov()
		polygon[0] = to_local(pov.global_position)
		render_polygon.polygon[0] = polygon[1]
		render_polygon.polygon[1] = polygon[2]
		render_polygon.polygon[2] = (polygon[2] + polygon[0].direction_to(polygon[2])*6400)
		render_polygon.polygon[3] = (polygon[1] + polygon[0].direction_to(polygon[1])*6400)
		
		render_polygon.uv = global_transform.xform(render_polygon.polygon)
