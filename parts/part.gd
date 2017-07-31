extends RigidBody2D

# The size of the collision shape.
onready var points = get_node("CollisionPolygon2D").get_polygon()

# This is dumb.
# Return the lowest y coordinate of the collision shape.
var ys = []
var ymax = 0
var ymin = 0
func lowest_y_coord():
	for point in points:
		ys.append(point.y)
	for y in ys:
		if y > 0:
			if y >= ymax:
				ymax = y
	return ymax
# Return the highest y coordinate of the collision shape.
func highest_y_coord():
	for point in points:
		ys.append(point.y)
	for y in ys:
		if y < 0:
			if y <= ymin:
				ymin = y
	return ymin

########
########

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
	########
	########
	print(lowest_y_coord())
	print(highest_y_coord())

func _unhandled_input(event):
	if is_touched == true:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			set_global_pos(get_global_mouse_pos())
