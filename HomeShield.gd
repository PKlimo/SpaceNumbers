extends Area2D

func open():
	get_node("ColorRect/AnimationPlayer").play("open")
	# get_node("sound").play() # sucast animacie

func close():
	get_node("ColorRect/AnimationPlayer").play("close")
	# get_node("sound").play() # sucast animacie	
