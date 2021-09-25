extends KinematicBody2D

var velocity := Vector2.ZERO
var look_dir := Vector2.RIGHT

var gravity := 20000
var run_max_speed := 10000
var jump_speed := 8000

var air := false

var ground_friction = 10
var air_movement = 0.5

var jump := false

func _ready():
	$Sprite/sight/light.visible = true

func _physics_process(delta):
	var move_dir = float(Input.is_action_pressed("right"))-float(Input.is_action_pressed("left"))
	var look = float(Input.is_action_pressed("down"))-float(Input.is_action_pressed("up"))
	
	$Sprite/sight.rotation_degrees = look*60
	
	if move_dir:
		if !air:
			velocity.x = lerp(velocity.x, run_max_speed*move_dir, delta)
		else:
			velocity.x = lerp(velocity.x, run_max_speed*move_dir, delta*air_movement)
	elif !air:
		velocity.x = lerp(velocity.x, 0, delta*ground_friction)
	
	if jump:
		jump = false
		if !air:
			velocity.y -= jump_speed
	
	
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

func _input(event):
	if event.is_action_pressed("A"):
		jump = true

func die():
	Signals.emit_signal("death")