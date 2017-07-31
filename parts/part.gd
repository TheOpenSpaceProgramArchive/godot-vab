extends RigidBody2D

# The points of the collision polygon.
onready var points = get_node("CollisionPolygon2D").get_polygon() # Vector2Array

# The size of the RayCast2D.
var ray_size = 50.0 # px

# This is dumb...
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

# Draw the RayCast2D.
func _draw():
	var from = Vector2(0.0, lowest_y_coord())
	var to = Vector2(0.0, lowest_y_coord() + ray_size)
	var color = Color(1.0, 1.0, 1.0)
	draw_line(from, to, color)

#################
# Good Code Begin
#################

# Is the mouse pointer touching the part?
var is_touched = false

func _on_mouse_enter():
	is_touched = true

func _on_mouse_exit():
	is_touched = false

func _unhandled_input(event):
	if is_touched == true:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			set_global_pos(get_global_mouse_pos())

func _ready():
	set_mode(MODE_STATIC)
	set_pickable(true)
	connect("mouse_enter", self, "_on_mouse_enter")
	connect("mouse_exit", self, "_on_mouse_exit")
	set_process_unhandled_input(true)

	###############
	# Good Code End
	###############

	get_node("DownRay").add_exception(self)
	get_node("DownRay").set_enabled(true)
	get_node("DownRay").set_cast_to(Vector2(0.0, lowest_y_coord() + 50.0))
	set_process(true)

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass
	elif get_node("DownRay").is_colliding():
		var potential_add = get_node("DownRay").get_collider()
		potential_add.set_pos(Vector2(get_pos().x, get_pos().y + lowest_y_coord() - potential_add.highest_y_coord()))
		get_node("PinJoint2D").set_node_a(self.get_path())
		get_node("PinJoint2D").set_node_b(potential_add.get_path())
