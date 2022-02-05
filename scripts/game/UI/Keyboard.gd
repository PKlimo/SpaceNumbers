extends Node2D

var od:int
var do:int

func allowed(key):
	return int(key) >= od and int(key) <= do
	
func draw():
	# od = 1
	# do = 3
	for i in get_children(): # kazdej klavese nastavi spravnu farbu, podla toho, ci je povolena
		if allowed(i.name):
			i.modulate = global_env.color_base
		else:
			i.modulate = Color(0.5,0.5,0.5)

func high(key): # highlight pressed key
	if not allowed(key):
		return
	for i in get_children():
		if i.name == str(key):
			i.modulate = Color(1,1,1)
			yield(get_tree().create_timer(0.5), "timeout")
			i.modulate = global_env.color_base

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
