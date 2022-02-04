extends Node2D

var sirka:int = 1024
var Enemy = preload("res://Enemy.tscn")
var level = load("res://Level.gd").new()
# only leve definition is here - no logic, all logic goes to World

var total_enemies:int = 10
var speed:int = 0 
const speedtable = [80, 100, 130] # 100, 150, 200, rekord 400
const roztable = [250, 200, 100] # 250, 200, 100
var rozostup:int = 0 
var rand_od:int = 0
var rand_do:int = 9
var sollution = []

func _ready():
	# print(global_env.level)
	rand_od = level.level_def[global_env.level]["od"]
	rand_do = level.level_def[global_env.level]["do"]
	speed = level.level_def[global_env.level]["speed"]
	
	get_node("../../Keyboard").od = rand_od
	get_node("../../Keyboard").do = rand_do
	get_node("../../Keyboard").draw()
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(total_enemies):
		var enemy = Enemy.instance()
		enemy.label_string = rng.randi_range(rand_od,rand_do)
		sollution.append(enemy.label_string)
		enemy.global_position = Vector2(i * roztable[rozostup],(rng.randi() % 450) + 50)
		enemy.speed = speedtable[speed]
		add_child(enemy)
	# print(sollution)
