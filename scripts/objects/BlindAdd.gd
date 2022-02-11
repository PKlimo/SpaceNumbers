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
	yield(self,"dead")
	
	var explosion = Explosion.instance()
	explosion.global_position = $TextureRect.global_position
	explosion.wait = 0.1
	get_node("/root/screen/World/Effects").add_child(explosion)
