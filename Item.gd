extends Area2D

func _ready():
	connect("body_entered", self, "_on_Item_body_entered")
	randomize()
	$Sprite.set_texture(load("Assets/pictures/items/powerupYellow" + str(randi() % 4 ) + ".png"))

func _on_Item_body_entered(_body):
	# player had collected the item
	get_parent().collect(self)
	# queue_free()
