extends KinematicBody2D

var velocity := Vector2.ZERO
var look_dir := Vector2.RIGHT

var gravity := 20000
var run_max_speed := 10000
var jump_speed := 11000

func _physics_process(delta):
	var move_dir = float(Input.is_action_pressed("right"))-float(Input.is_action_pressed("left"))
	velocity.x = lerp(velocity.x, run_max_speed*move_dir, delta)
	
	velocity.y += gravity*delta
	
	var vel = move_and_slide(velocity*delta, Vector2.UP)
	if !vel.x:
		velocity.x = 0
	if is_on_floor() or is_on_ceiling():
		velocity.y = 0


func _input(event):
	if event.is_action_pressed("A"):
		velocity.y -= jump_speed
