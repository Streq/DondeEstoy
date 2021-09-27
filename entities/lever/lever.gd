extends "res://entities/actionable/actionable.gd"

signal on()
signal off()

var is_on = false

func on():
	$sprite.scale.x = -1
	is_on = true
	emit_signal("on")

func off():
	$sprite.scale.x = 1
	is_on = false
	emit_signal("off")

func trigger():
	if is_on:
		off()
	else:
		on()
