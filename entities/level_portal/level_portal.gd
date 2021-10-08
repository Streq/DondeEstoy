extends Node2D

func trigger():
	Signals.emit_signal("next_level")
