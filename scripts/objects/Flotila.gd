extends "res://scripts/objects/Enemy.gd"

func _ready():
	# pred tymto sa zavola Enemy._ready() ktora nastavi visibilitu a texturu spritu
	kon -=120

	for i in $skupina.get_children():
		if i is TextureRect:
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
	for i in $skupina.get_children():
		if i is TextureRect:
			yield(get_tree().create_timer(0.05), "timeout")
			i.self_modulate = Color(0,0,0,0)
			i.get_node("Explosion/Animation").play("explosion")
