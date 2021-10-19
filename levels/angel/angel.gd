extends KinematicBody2D

export(float) var SPEED: float = 600
export(int, LAYERS_2D_PHYSICS) var visibility_layers := 0

var velocity: Vector2 = Vector2.ZERO

var path: Array = []
var new_path: Array = []
var levelNavigation: Navigation2D = null
var player = null
var last_seen = null

var can_see_me = false

func _ready():
	var tree = get_tree()
	yield(get_tree(),"idle_frame")
	if tree and tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("player"):
		player = tree.get_nodes_in_group("player")[0]


func _physics_process(delta):
	generate_path()
	navigate()
	$sprite.flip_h = velocity.x<0
	move()
	yield(get_tree(),"idle_frame")
	can_see_me = can_player_see_me()

func navigate():
	if path.size() > 1:
		velocity = global_position.direction_to(path[1]) * SPEED
	
		if global_position.distance_squared_to(path[0]) < SPEED*SPEED:
			path.pop_front()
	else:
		velocity = Vector2.ZERO
func generate_path():
	if levelNavigation and player:
		new_path = levelNavigation.get_simple_path(global_position, player.global_position, true)
		if new_path.size() > 1:
			path = new_path
			last_seen = player.global_position
		elif last_seen: 
			path = levelNavigation.get_simple_path(global_position, last_seen, true)
func move():
	if !can_see_me:
		velocity = move_and_slide(velocity)
	
func can_player_see_me():
	var tree = get_tree()
	if tree:
		var players = get_tree().get_nodes_in_group("player")
		if players.size():
			var player = players[0] 
			var target = player.get_pov().get_origin()
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_ray($sight.global_position, target, [], visibility_layers)
			return result.has("collider") and result.collider.is_in_group("can_see")
	return false
