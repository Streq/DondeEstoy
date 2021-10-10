extends Node2D

signal on()
signal off()

var is_on = false
export(bool) var one_time_use = false

func on():
	$sprite.scale.x = -1
	is_on = true
	emit_signal("on")

func off():
	$sprite.scale.x = 1
	is_on = false
	emit_signal("off")

func trigger():
	if one_time_use:
		$actionable.queue_free()
	if is_on:
		off()
	else:
		on()
