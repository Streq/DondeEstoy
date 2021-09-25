extends Area2D

onready var body = $body

var is_open = false

func open():
	$open.visible=true
	$closed.visible=false
	remove_child(body)
	is_open = true

func close():
	$open.visible=false
	$closed.visible=true
	add_child(body)
	is_open = false

func trigger():
	if is_open:
		close()
	else:
		open()

func _input(event):
	if event.is_action_pressed("B"):
		trigger()


func _on_body_entered(body):
	pass # Replace with function body.


func _on_body_exited(body):
	pass # Replace with function body.
