extends Node

var Item = preload("res://Item.tscn")

func addItem(pos, wait = 0):
	var item = Item.instance()
	item.global_position = pos
	yield(get_tree().create_timer(wait), "timeout")
	add_child(item)

func collect(item):
	# print("collected")
	$sound.play()
	get_node("../../Radar").add(item)
	item.queue_free()

func all() -> bool:
	# print(get_child_count())
	return get_child_count() == 1

func remove_one(): # penalty for missed shot or pause
	if get_child_count() > 1: # if there is anything other than sound
		# get_children()[-1]
		get_children()[-1].queue_free() # remove last item

func remove_out_of_screen():
	for i in get_children():
		if i.is_class("Area2D"): # because we have sound children
			if i.global_position.x > 1024:
				i.queue_free()
			
