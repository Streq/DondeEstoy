extends KinematicBody2D

signal action()

var velocity := Vector2.ZERO

export (float, -1, 1, 2) var look_dir := 1.0

var gravity := 20000
var run_max_speed := 10000
var crouch_max_speed := 2000
var walk_max_speed := 6000
var jump_speed := 8000

var air := false

var ground_friction = 10
var air_movement = 0.5

var jump := false

var crouching = false

var walking = false

func _ready():
	$Sprite/sight/light.visible = true

func _physics_process(delta):
	var move_dir = float(Input.is_action_pressed("right"))-float(Input.is_action_pressed("left"))
	var look = float(Input.is_action_pressed("down"))-float(Input.is_action_pressed("up"))
	var crouch = Input.is_action_pressed("R") or !can_stand()
	var walk = Input.is_action_pressed("L")
	
	$Sprite/sight.rotation_degrees = look*60
	
	if move_dir:
		if !air:
			if (crouching or walk) and sign(move_dir)!=sign(velocity.x):
				velocity.x = lerp(velocity.x, 0, delta*ground_friction)
			if crouching:
				velocity.x = lerp(velocity.x, crouch_max_speed*move_dir, delta)
			elif walk:
				velocity.x = lerp(velocity.x, walk_max_speed*move_dir, delta)
			else:
				velocity.x = lerp(velocity.x, run_max_speed*move_dir, delta)
		else:
			velocity.x = lerp(velocity.x, run_max_speed*move_dir, delta*air_movement)
	elif !air:
		velocity.x = lerp(velocity.x, 0, delta*ground_friction)
	
	if jump:
		jump = false
		if !air:
			velocity.y -= jump_speed
	
	
	$Sprite.scale.x = look_dir
	
	velocity.y += gravity*delta
	
	var vel = move_and_slide(velocity*delta, Vector2.UP)
	
	air = !is_on_floor()
	
	if !air and velocity.y > 0 or is_on_ceiling() and velocity.y < 0:
		velocity.y = 0
	if is_on_wall():
		velocity.x = 0
	if air:
		if can_stand():
			$AnimationPlayer.play("air")
	elif move_dir:
		if (!crouching 
			or abs(velocity.x)<crouch_max_speed*0.5 
			or sign(move_dir) == sign(velocity.x)
		):
			if !walk:
				look_dir = move_dir
		if crouch:
			if velocity.x > run_max_speed*0.6:
				$AnimationPlayer.play("crouch_slide")
			else:
				$AnimationPlayer.play("crouch_walk")
		else:
			if walk:
				$AnimationPlayer.play("walk")
			else:
				$AnimationPlayer.play("run")
	else:
		if crouch:
			if velocity.x > run_max_speed*0.6:
				$AnimationPlayer.play("crouch_slide")
			else:
				$AnimationPlayer.play("crouch")
		else:
			$AnimationPlayer.play("idle")

func _input(event):
	if event.is_action_pressed("A"):
		jump = true
	if event.is_action_pressed("B"):
		emit_signal("action")
	if event.is_action_pressed("full_view") and OS.is_debug_build():
		$Sprite/sight.visible = !$Sprite/sight.visible
	

func die():
	Signals.emit_signal("death")
#	get_tree().reload_current_scene()


func _on_hitbox_body_entered(body):
	die()

func get_pov():
	return $Sprite/sight/light.global_transform

func crouch(val):
	if crouching == val:
		return
	crouching = val
	if val:
		$Sprite.position.y = 5
		$crouch_shape.disabled = false
		yield(get_tree(),"idle_frame")
		$stand_shape.disabled = true
	else:
		$Sprite.position.y = 0
		$stand_shape.disabled = false
		yield(get_tree(),"idle_frame")
		$crouch_shape.disabled = true
	
func can_stand():
	return $stand_area.count == 0
