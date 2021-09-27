extends Area2D

func _ready():
	connect("body_entered",self,"_body_entered")
	connect("body_exited",self,"_body_exited")
	
func _body_entered(body):
	if body.is_in_group("player"):
		body.connect("action",self,"trigger")

func _body_exited(body):
	if body.is_in_group("player"):
		body.disconnect("action",self,"trigger")	

func trigger():
	Signals.emit_signal("next_level")
