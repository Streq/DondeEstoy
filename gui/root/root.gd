extends CanvasLayer


export (int) var main_vp_width
export (int) var main_vp_height
export (PackedScene) var game_scene

var current_scene = null

# don't forget to use stretch mode 'disabled' and aspect 'ignore'
onready var viewport_container = $display_container
onready var game_container = $display_container/main_viewport/game_container
onready var game_viewport = $display_container/main_viewport/game_container/game_viewport

func _ready():
	get_tree().connect("screen_resized", self, "_screen_resized")
	reset()
#	call_deferred("_set_game_scene",current_scene)
	_set_game_scene(game_scene.instance())
	
func reset():
	game_container.rect_size = Vector2(main_vp_width, main_vp_height)
	_screen_resized()


func _screen_resized():
	var window_size = OS.get_window_size()

	# see how big the window is compared to the viewport size
	#vpw = viewports per window
	var vpw_x = window_size.x / (main_vp_width)
	var vpw_y = window_size.y / (main_vp_height)
	
	# floor it so we only get round numbers (0, 1, 2, 3 ...)
	var scale_x = floor(vpw_x)
	var scale_y = floor(vpw_y)

	# use the smaller scale with 1x minimum scale
	var scale = max(1, min(scale_x, scale_y))
	
	viewport_container.rect_size = OS.get_window_size()
	viewport_container.rect_scale = Vector2(1,1)*scale
	game_container.rect_position = viewport_container.rect_size * 0.5 / scale - game_container.rect_size*0.5
	
func _set_game_scene(scene):
	if current_scene:
		game_viewport.remove_child(current_scene)
	current_scene = scene
	game_viewport.add_child(scene)
