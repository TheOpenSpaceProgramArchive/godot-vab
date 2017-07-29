extends RigidBody2D

# Is the mouse inside of the object?
var mouse_captured = false

# Is the mouse pressed and the object being dragged?
var object_dragged = false

func on_mouse_enter():
	mouse_captured = true

func on_mouse_exit():
	mouse_captured = false

func _ready():
	set_pickable(true)
	set_process(true)
	set_process_input(true)
	# Connect object's mouse enter/exit signals
	connect("mouse_enter", self, "on_mouse_enter")
	connect("mouse_exit", self, "on_mouse_exit")

# Escape to exit.
func _input(event):
	if (event.type == InputEvent.KEY) :
		if (event.scancode == KEY_ESCAPE) :
			get_tree().quit()

func _process(delta):
	if mouse_captured == true:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			object_dragged = true
		else:
			object_dragged = false
	if object_dragged == true:
		set_global_pos(get_global_mouse_pos())
