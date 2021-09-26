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



func _on_body_entered(body):
	if body.is_in_group("player"):
		body.connect("action", self, "trigger")


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.disconnect("action", self, "trigger")

