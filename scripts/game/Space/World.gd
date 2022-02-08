extends Node2D
signal kill_enemy # zachytava screen/Radar
signal win # zachytava screen/WinScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_HomeShield_area_entered(area):
	if area.is_in_group("enemy"):
		# game over
		get_tree().paused = true
		get_node("../GameOverBlackScreen/AnimationPlayer").play("fade_to_black")

func _on_HomeShield_body_entered(_body):
	# print(body)
	if $Items.all():
		$PlayerShip.global_position.x = 45
		$PlayerShip.can_move = false
		$HomeShield.close()
		yield(get_tree().create_timer(1.9), "timeout")
		if get_tree().change_scene("res://TitleScreen.tscn") != OK:
			print("Error loading scene res://TitleScreen.tscn")

func any_visible_enemies():
	for i in $Level.get_children():
		if i.visible == true:
			return true
	return false

func _on_screen_keypad(key):
	# print(get_node("Level").sollution)
	# print(key)
	if $Level.sollution.size() == 0:
		return
	if not get_node("../Keyboard").allowed(key):
		return
	if not any_visible_enemies():
		return
	if $Level.get_child_count() != $Level.sollution.size(): # entry from sollution is removed, but not object (because of animation)
		return
	get_node("../Keyboard").high(key)
	if get_node("Level").sollution[0] == key:
		# print("hit")
		emit_signal("kill_enemy")
		get_node("Level").sollution.remove(0) # remove hit from sollutions
		get_node("Level").get_children()[0].hit() # play animation and remove yourself
		var pos = get_node("Level").get_children()[0].global_position
		var pauza = get_node("Level").get_children()[0].get_node("EnemySprite/Explosion/Animation").get_animation("explosion").length
		get_node("Items").addItem(pos, pauza) #add item on position of enemy
		if get_node("Level").get_child_count() == 1:
			emit_signal("win")
	else:
		# print("missed")
		$Items.remove_one()
		get_node("Level").get_children()[0].missed()


func _on_win_animation_finished(_anim):
	get_node("HomeShield").open()
	get_node("PlayerShip").can_move = true


