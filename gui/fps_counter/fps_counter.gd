extends Label

func _ready():
#	visible = Globals.debug
	pass

func _process(delta):
	text = String(Engine.get_frames_per_second())
