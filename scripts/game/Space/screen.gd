extends Node2D

signal keypad(key)

func _on_AnimationPlayer_animation_finished(_anim_name):
	get_node("Popup").popup_centered()
	pass # Replace with function body.

func _ready():
	toggle_pause()

func _on_Restart_pressed():
	if get_tree().reload_current_scene() != OK:
		print("Error reloading screne")
	get_tree().paused = false

func toggle_pause():
	get_tree().paused = not get_tree().paused
	get_node("PauseScreen").visible = get_tree().paused

func _input(event):
	if event is InputEventKey and event.is_pressed():
		# print(event.scancode)
		if event.scancode == KEY_SPACE:
			get_node("PauseScreen/sound").play()
			toggle_pause()
		if event.scancode >= KEY_KP_0 and event.scancode <= KEY_KP_9:
			# https://docs.godotengine.org/en/stable/classes/class_inputeventkey.html#class-inputeventkey
			# https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-keylist
			emit_signal("keypad",event.scancode - KEY_KP_0)
		if event.scancode == KEY_ESCAPE:
			get_tree().paused = false
			if get_tree().change_scene("res://TitleScreen.tscn") != OK:
				print("Error loading scene res://TitleScreen.tscn")
