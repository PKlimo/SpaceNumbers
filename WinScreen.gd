extends ColorRect

func _on_World_win():
	get_node("../Keyboard").visible = false
	get_node("AnimationPlayer").play("show")
	get_node("../World/Items").remove_out_of_screen()
