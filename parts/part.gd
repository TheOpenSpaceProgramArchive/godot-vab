extends RigidBody2D

# Is the mouse pointer touching the part?
var is_mouse_touching = false

func _on_mouse_enter():
	is_mouse_touching = true

func _on_mouse_exit():
	is_mouse_touching = false

func _ready():
	set_pickable(true)
	connect("mouse_enter", self, "_on_mouse_enter")
	connect("mouse_exit", self, "_on_mouse_exit")
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if is_mouse_touching == true:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			set_global_pos(get_global_mouse_pos())
