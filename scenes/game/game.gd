extends Control

export (Array, PackedScene) var levels

var _current_level = null

var player


func _ready():
	Signals.connect("death",self,"_on_death")
	_current_level = levels[0].instance()
	add_child(_current_level)

func _on_death():
	Signals.emit_signal("push_scene", Scenes.death.instance())
