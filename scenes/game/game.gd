extends Control

export (Array, PackedScene) var levels

var _current_level = null
var _current_index = 0

var player


func _ready():
	Signals.connect("death",self,"_on_death")
	Signals.connect("next_level",self,"_next_level")
	_current_level = levels[_current_index].instance()
	add_child(_current_level)

func _on_death():
	_restart_level()
	Signals.emit_signal("push_scene", Scenes.death.instance())
	
func _restart_level():
	_current_level.queue_free()
	_current_level = levels[_current_index].instance()
	add_child(_current_level)

func _next_level():
	_current_index += 1
	_restart_level()
