extends Control

export (Array, PackedScene) var levels

var _current_level = null
var _current_index = 0

var death = null
var dead = false

var checkpoint = null

var player


func _ready():
	_current_level = levels[_current_index].instance()
	add_child(_current_level)
	

func _enter_tree():
	Signals.connect("death",self,"_on_death")
	Signals.connect("next_level",self,"_next_level")
	Signals.connect("restart_level",self,"_restart_level")
	Signals.connect("checkpoint", self, "_checkpoint")

func _exit_tree():
	Signals.disconnect("death",self,"_on_death")
	Signals.disconnect("next_level",self,"_next_level")
	Signals.disconnect("restart_level",self,"_restart_level")
	Signals.disconnect("checkpoint", self, "_checkpoint")
	
func _checkpoint(position):
	checkpoint = position

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
	
	#to prevent showing one frame of the initial position before we move
	#the player to the checkpoint, if there is one
	VisualServer.render_loop_enabled = false
	
	_current_level = levels[_current_index].instance()
	yield(get_tree(),"idle_frame")
	add_child(_current_level)
	if checkpoint:
		var players = get_tree().get_nodes_in_group("player")
		if players.size():
			players[0].global_position = checkpoint
	yield(get_tree(),"idle_frame")
	
	#now we can show the game again
	VisualServer.render_loop_enabled = true


func _next_level():
	_current_index += 1
	checkpoint = null
	_restart_level()
