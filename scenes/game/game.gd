extends Control

export (Array, PackedScene) var levels

var _current_level = null
var _current_index = 0

var death = null
var dead = false

var player


func _ready():
	_current_level = levels[_current_index].instance()
	add_child(_current_level)
	

func _enter_tree():
	Signals.connect("death",self,"_on_death")
	Signals.connect("next_level",self,"_next_level")
	Signals.connect("restart_level",self,"_restart_level")
	

func _exit_tree():
	Signals.disconnect("death",self,"_on_death")
	Signals.disconnect("next_level",self,"_next_level")
	Signals.disconnect("restart_level",self,"_restart_level")
	
	
func _on_death():
	if !dead:
		dead = true
		if !death:
			death = Scenes.death.instance()
	
		call_deferred("remove_child",_current_level)
		call_deferred("add_child",death)
	
func _restart_level():
	if dead:
		remove_child(death)
		dead = false
	_current_level.queue_free()
	_current_level = levels[_current_index].instance()
	call_deferred("add_child",_current_level)

func _next_level():
	_current_index += 1
	_restart_level()
