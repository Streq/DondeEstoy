extends Control

var levels
var player


func _ready():
	Signals.connect("death",self,"_on_death")
	
	
func _on_death():
	Signals.emit_signal("push_scene", Scenes.death)
