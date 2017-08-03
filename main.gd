extends Node

func save_game():
	var savegame = File.new()
	savegame.open("res://savegame.save", File.WRITE)
	var savenodes = get_tree().get_nodes_in_group("rocket_group")
	for i in savenodes:
		var nodedata = i.save()
		savegame.store_line(nodedata.to_json())
	savegame.close()

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if Input.is_key_pressed(KEY_K):
		save_game()
