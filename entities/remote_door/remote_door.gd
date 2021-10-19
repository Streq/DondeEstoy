extends Node2D

#door that must be opened through code

onready var body = $body

var is_open = false

func open():
	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("hint")
	$open.visible = true
	$closed.visible = false
	remove_child(body)
	is_open = true

func close():
	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("hint")
	$open.visible = false
	$closed.visible = true
	add_child(body)
	is_open = false

func trigger():
	if is_open:
		close()
	else:
		open()
