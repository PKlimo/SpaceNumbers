extends Node

var Item = preload("res://Item.tscn")

func addItem(pos):
	var item = Item.instance(PackedScene.GEN_EDIT_STATE_MAIN)
	item.global_position = pos
	add_child(item)

func collect(item):
	# print("collected")
	$sound.play()
	get_node("../../Radar").add(item)
	item.queue_free()

func all() -> bool:
	# print(get_child_count())
	return get_child_count() == 1

func remove_out_of_screen():
	for i in get_children():
		if i.is_class("Area2D"): # because we have sound children
			if i.global_position.x > 1024:
				i.queue_free()
			
