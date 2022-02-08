extends "res://scripts/objects/Enemy.gd"

func _ready():
	# pred tymto sa zavola Enemy._ready() ktora nastavi visibilitu a texturu spritu
	kon -=60
	var c1 = randi() % (int(label_string) -1) + 1
	var c2 = int(label_string) - c1
	var j
	
	$EnemyLabel.text = str(c1)
	$EnemyLabel2.text = str(c2)
	
	j = 0
	for i in $skupina.get_children():
		if j < c1 -1 : # lebo sprite je jedna lodka
			i.set_texture($EnemySprite.texture)
		else:
			i.queue_free()
		j += 1
	
	j = 0
	for i in $skupina2.get_children():
		if j < c2:
			i.set_texture($EnemySprite.texture)
		else:
			i.queue_free()
		j += 1

func hit():
	.hit()
	var off = 0.1
	for i in $skupina.get_children():
		var explosion = Explosion.instance()
		explosion.global_position = i.global_position
		explosion.wait = off
		off += 0.1
		get_node("/root/screen/World/Effects").add_child(explosion)
	for i in $skupina2.get_children():
		var explosion = Explosion.instance()
		explosion.global_position = i.global_position
		explosion.wait = off
		off += 0.1
		get_node("/root/screen/World/Effects").add_child(explosion)
	
