extends "res://scripts/objects/Enemy.gd"

func _ready():
	# pred tymto sa zavola Enemy._ready() ktora nastavi visibilitu a texturu spritu
	kon -=120

	for i in $skupina.get_children():
		i.set_texture($EnemySprite.texture)
	
	# delete random ship
	var del = range($skupina.get_child_count())
	del.shuffle()
	# print(int(label_string))
	# print(del)
	# print(del.slice(int(label_string)-1,9))
	for i in del.slice(int(label_string)-1,9):
		$skupina.get_children()[i].queue_free() 

func hit():
	.hit()
	yield(self,"dead")
	var off = 0.1
	for i in $skupina.get_children():
		var explosion = Explosion.instance()
		explosion.global_position = i.global_position
		explosion.wait = off
		off += 0.1
		get_node("/root/screen/World/Effects").add_child(explosion)
