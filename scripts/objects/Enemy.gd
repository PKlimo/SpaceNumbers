extends Area2D

var speed:int
var label_string
var live = true
onready var zac = 20 + get_parent().get_parent().global_position.x # World offset
onready var kon = zac - 40 + get_node("../../Space").rect_size.x #Worls size

func _ready():
	randomize()
	visible = false
	$EnemyLabel.text = str(label_string)
	$EnemySprite.set_texture(load("res://Assets/pictures/enemies/enemyBlack" + str(randi() % 5 + 1) + "_r.png"))

func _physics_process(delta):
	if live:
		visible = global_position.x < kon and global_position.x > zac
		global_position.x -= speed * delta

func hit():
	live = false
	# TODO draw laser / line from player to current position
	get_node("../../Laser").fire(Vector2(global_position.x-50,global_position.y-110))

	# TODO animacia a explozia po skonceni animacie vymaze sam seba
	queue_free()

func missed():
	get_node("../../Laser").fire(Vector2(global_position.x-50,global_position.y-110),true)
