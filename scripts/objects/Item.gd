extends Area2D

func _ready():
	if connect("body_entered", self, "_on_Item_body_entered") != OK:
		print("Error connecting signal on_Item_body_entered")
	randomize()
	$Sprite.set_texture(load("res://Assets/pictures/items/powerupYellow" + str(randi() % 4 ) + ".png"))

func _on_Item_body_entered(body):
	# player had collected the item
	if body.name == "PlayerShip":
		get_parent().collect(self)
	# queue_free()
