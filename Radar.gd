extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_node("../World/Level").get_children():
		var enemy = TextureRect.new()
		var image = i.get_node("EnemySprite").texture.get_data()
		image.resize(42, 46)
		var itex = ImageTexture.new()
		itex.create_from_image(image)
		enemy.texture = itex
		add_child(enemy)

func _on_World_kill_enemy():
	get_children()[0].queue_free()

func add(input_item):
	var item = TextureRect.new()
	var itex = ImageTexture.new()
	var image = input_item.get_node("Sprite").texture.get_data()
	itex.create_from_image(image)
	item.texture = itex
	add_child(item)
