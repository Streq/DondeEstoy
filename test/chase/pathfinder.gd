extends KinematicBody2D

export(float) var SPEED: float = 30
var velocity: Vector2 = Vector2.ZERO

var path: Array = []
var new_path: Array = []
var levelNavigation: Navigation2D = null
var player = null
var last_seen = null

func _ready():
	yield(get_tree(),"idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("player"):
		player = tree.get_nodes_in_group("player")[0]


func _physics_process(delta):
	generate_path()
	navigate()
	$sprite.flip_h = velocity.x<0
	move()

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
	velocity = move_and_slide(velocity)
