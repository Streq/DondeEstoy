extends "res://entities/actionable/actionable.gd"

func trigger():
	Signals.emit_signal("next_level")
