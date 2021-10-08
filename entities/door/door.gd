extends Node2D

var open := false

func _ready():
	$actionable.connect("triggered", self, "trigger")

func trigger():
	$remote_door.trigger()
	open = !open
	if open:
		$actionable/interact_message.message = "X - cerrar"
	else:
		$actionable/interact_message.message = "X - abrir"
