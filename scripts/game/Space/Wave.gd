extends Node2D

var sirka:int = 1024
var Enemy = preload("res://scenes/Enemies/Enemy.tscn")
var Flotila = preload("res://scenes/Enemies/Flotila.tscn")
var Addition = preload("res://scenes/Enemies/Addition.tscn")
var BlindAdd = preload("res://scenes/Enemies/BlindAdd.tscn")  
var level = load("res://scripts/game/TitleScreen/Level.gd").new()
# only leve definition is here - no logic, all logic goes to World

var total_enemies:int = 10
var rozostup:int
var rand_od:int = 0
var rand_do:int = 9
var sollution = []
var place_min:int
var place_max:int
var typ

func _ready():
	# print(global_env.level)
	rand_od = level.level_def[global_env.level]["od"]
	rand_do = level.level_def[global_env.level]["do"]
	typ = level.level_def[global_env.level]["typ"]
	
	get_node("../../Keyboard").od = rand_od
	get_node("../../Keyboard").do = rand_do
	get_node("../../Keyboard").draw()
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(total_enemies):
		var enemy
		if typ == "E":
			enemy = Enemy.instance()
			rozostup = 250
			place_min = 50
			place_max = 450
		elif typ == "A":
			enemy = Addition.instance()
			rozostup = 450
			place_min = 220
			place_max = 300
		elif typ == "B":
			enemy = BlindAdd.instance()
			rozostup = 450
			place_min = 50
			place_max = 450
		elif typ == "F":
			enemy = Flotila.instance()
			rozostup = 400
			place_min = 90
			place_max = 390
		else:
			print("unknown type ", typ)
			
		enemy.label_string = rng.randi_range(rand_od,rand_do)
		sollution.append(enemy.label_string)
		enemy.global_position = Vector2(i * rozostup,(rng.randi() % place_max) + place_min)
		enemy.speed = level.level_def[global_env.level]["sp"]
		add_child(enemy)
	# print(sollution)
