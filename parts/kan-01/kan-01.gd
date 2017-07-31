extends "res://parts/part.gd"

# The RayCast2D length of the part.
var ray_length = 50.0 # px

func _draw():
	var from = Vector2(0.0, ray_length) # px
	var to = Vector2(0.0, -ray_length) # px
	var color = Color(1.0, 1.0, 1.0) # white
	draw_line(from, to, color)

func _ready():
	get_node("DownRay").add_exception(self)
	set_process(true)

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass
	elif get_node("DownRay").is_colliding():
		var potential_add = get_node("DownRay").get_collider()
		potential_add.set_pos(Vector2(get_pos().x, get_pos().y + lowest_y_coord() - potential_add.highest_y_coord()))
		print(get_item_rect())
