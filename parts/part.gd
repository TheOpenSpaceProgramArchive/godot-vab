extends RigidBody2D

# Is the mouse pointer touching the part?
var is_touched = false

func _on_mouse_enter():
	is_touched = true

func _on_mouse_exit():
	is_touched = false

func _ready():
	set_mode(MODE_STATIC)
	set_pickable(true)
	connect("mouse_enter", self, "_on_mouse_enter")
	connect("mouse_exit", self, "_on_mouse_exit")
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if is_touched == true:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			set_global_pos(get_global_mouse_pos())
