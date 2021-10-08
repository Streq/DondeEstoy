tool
extends Node2D

export (String) var message:String setget _set_message


func _on_triggereable(val):
	visible = val
	
func _set_message(_message):
	if !_message:
		_message = ""
	message = _message
	if has_node("CenterContainer"):
		$CenterContainer/game_label.text = _message
