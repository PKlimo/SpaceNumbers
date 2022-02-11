extends Area2D

signal dead

var Explosion = preload("res://scenes/Effects/Explosion.tscn")
var Rocket = preload("res://scenes/Effects/Rocket.tscn")

var gun = "rocket"

var speed:int
var label_string
var live = true

onready var zac = 20 + get_parent().get_parent().global_position.x # World offset
onready var kon = zac - 40 + get_node("../../Space").rect_size.x #Worls size

func _ready():
	$shield.visible = false
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
	if gun == "laser":
		get_node("../../Laser").fire(Vector2(global_position.x-50,global_position.y-110))
	elif gun == "rocket":
		var rocket = Rocket.instance()
		rocket.target = self
		get_node("/root/screen/World/Effects").add_child(rocket)
	
		yield(get_node("/root/screen/World/Effects/Rocket"), "area_entered")
		get_node("/root/screen/World/Effects/Rocket").queue_free()
	
	emit_signal("dead")
	var explosion = Explosion.instance()
	explosion.global_position = self.global_position
	explosion.sound = true
	get_node("/root/screen/World/Effects").add_child(explosion)
	queue_free() 

func missed():
	if gun == "laser":
		get_node("../../Laser").fire(Vector2(global_position.x-50,global_position.y-110),true)
	elif gun == "rocket":
		$shield.visible = true
		var rocket = Rocket.instance()
		rocket.target = self
		get_node("/root/screen/World/Effects").add_child(rocket)
	
		yield(get_node("/root/screen/World/Effects/Rocket"), "area_entered")
		get_node("/root/screen/World/Effects/Rocket").queue_free()
		$shield.visible = false
