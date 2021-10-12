extends KinematicBody2D

var velocity := Vector2.ZERO
var look_dir := Vector2.RIGHT

var gravity := 20000
var run_max_speed := 10000
var jump_speed := 6000

var air := false

var ground_friction = 10
var air_movement = 0.5

var jump := false

var target := Vector2.ZERO
var spotted := false

var jump_timer := 0.0

export (int, LAYERS_2D_PHYSICS) var layer_2d_visible

func _physics_process(delta):
	look_for_player()
	
	if spotted and (target.y < global_position.y or velocity.x == 0.0):
		jump_timer += delta
	else:
		jump_timer = 0
		jump = false
	
	if jump_timer > 0.5:
		jump = true
	
	
	var move_dir = float(spotted) * sign(target.x-global_position.x)
	
	if move_dir:
		if !air:
			velocity.x = lerp(velocity.x, run_max_speed*move_dir, delta)
			if jump:
				velocity.y -= jump_speed
		else:
			velocity.x = lerp(velocity.x, run_max_speed*move_dir, delta*air_movement)
	elif !air:
		velocity.x = lerp(velocity.x, 0, delta*ground_friction)
	
	$Sprite.scale.x = look_dir.x
	
	velocity.y += gravity*delta
	
	var vel = move_and_slide(velocity*delta, Vector2.UP)
	
	air = !is_on_floor()
	
	if !air and velocity.y > 0 or is_on_ceiling() and velocity.y < 0:
		velocity.y = 0
	if is_on_wall():
		velocity.x = 0
	if air:
		$AnimationPlayer.play("air")
	elif move_dir:
		look_dir.x = move_dir
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")

func look_for_player():
	var players = get_tree().get_nodes_in_group("player")
	if players.size():
		var player = players[0] 
		target = player.global_position
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, target, get_tree().get_nodes_in_group("monster"), layer_2d_visible)
		spotted = (result.has("collider") and result.collider == player)
		
func die():
	queue_free()
