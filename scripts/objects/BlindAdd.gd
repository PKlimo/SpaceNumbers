extends "res://scripts/objects/Enemy.gd"

func _ready():
	kon -=60
	var c1 = randi() % (int(label_string) -1) + 1
	var c2 = int(label_string) - c1
	
	$EnemyLabel.text = str(c1)
	$EnemyLabel2.text = str(c2)

	$TextureRect.set_texture($EnemySprite.texture)

func hit():
	.hit()
	$EnemyLabel2.visible = false
	yield(get_tree().create_timer(0.1), "timeout")
	$TextureRect.self_modulate = Color(0,0,0,0)	
	$TextureRect/Explosion/Animation.play("explosion")
	
