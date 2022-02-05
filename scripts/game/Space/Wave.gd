extends Node2D

var sirka:int = 1024
var Enemy = preload("res://scenes/Enemies/Enemy.tscn")
var Flotila = preload("res://scenes/Enemies/Flotila.tscn")
var Addition = preload("res://scenes/Enemies/Addition.tscn")
var BlindAdd = preload("res://scenes/Enemies/BlindAdd.tscn")  
var level = load("res://scripts/game/TitleScreen/Level.gd").new()
# only leve definition is here - no logic, all logic goes to World

var total_enemies:int = 10
var speed:int = 0 
const speedtable = [80, 100, 110] # 100, 150, 200, rekord 400
const roztable = [400, 250, 200, 100] # 250, 200, 100
var rozostup:int = 1 
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
	speed = level.level_def[global_env.level]["speed"]
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
		elif typ == "A":
			enemy = Addition.instance()
		elif typ == "B":
			enemy = BlindAdd.instance()
		elif typ == "F":
			enemy = Flotila.instance()
		else:
			print("unknown type ", typ)
			
		
		if enemy.name == "Flotila":
			rozostup = 0
			place_min = 90
			place_max = 390
		elif enemy.name == "Addition":
			rozostup = 0
			place_min = 220
			place_max = 300
		elif enemy.name == "BlindAdd":
			rozostup = 0
			place_min = 50
			place_max = 450
		elif enemy.name == "Enemy":
			rozostup = 1
			place_min = 50
			place_max = 450
		else:
			print("Unknown type ", enemy.name)

		enemy.label_string = rng.randi_range(rand_od,rand_do)
		sollution.append(enemy.label_string)
		enemy.global_position = Vector2(i * roztable[rozostup],(rng.randi() % place_max) + place_min)
		enemy.speed = speedtable[speed]
		add_child(enemy)
	# print(sollution)
