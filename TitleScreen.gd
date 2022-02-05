extends Node2D

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
