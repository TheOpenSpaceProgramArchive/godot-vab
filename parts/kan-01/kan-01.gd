extends "res://parts/part.gd"

# The RayCast2D length of the part.
var ray_length = 50.0 # px

func _draw():
	var from = Vector2(0.0, ray_length) # px
	var to = Vector2(0.0, -ray_length) # px
	var color = Color(1.0, 1.0, 1.0) # white
	draw_line(from, to, color)

func _ready():
	print("whatever")