extends Node2D

#door that must be opened through code

onready var body = $body

var is_open = false

func open():
	$open.visible = true
	$closed.visible = false
	remove_child(body)
	is_open = true

func close():
	$open.visible = false
	$closed.visible = true
	add_child(body)
	is_open = false

func trigger():
	if is_open:
		close()
	else:
		open()
