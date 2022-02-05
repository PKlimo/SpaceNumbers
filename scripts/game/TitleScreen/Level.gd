extends Area2D

var lvl # index in level_def - name of node
var level_def = {
	"1":{"od":1, "do":3, "speed":0, "typ":"E"},
	"2":{"od":1, "do":3, "speed":1, "typ":"E"},
	"3":{"od":1, "do":3, "speed":2, "typ":"E"},
	"4":{"od":4, "do":6, "speed":0, "typ":"E"},
	"5":{"od":4, "do":6, "speed":1, "typ":"E"},
	"6":{"od":4, "do":6, "speed":2, "typ":"E"},
	"7":{"od":7, "do":9, "speed":0, "typ":"E"},
	"8":{"od":7, "do":9, "speed":1, "typ":"E"},
	"9":{"od":7, "do":9, "speed":2, "typ":"E"},
	"10":{"od":0, "do":9, "speed":0, "typ":"E"},
	"11":{"od":0, "do":9, "speed":1, "typ":"E"},
	"12":{"od":0, "do":9, "speed":2, "typ":"E"},
	"13":{"od":1, "do":3, "speed":0, "typ":"F"},
	"14":{"od":1, "do":6, "speed":0, "typ":"F"},
	"15":{"od":1, "do":9, "speed":0, "typ":"F"},
	"16":{"od":1, "do":9, "speed":1, "typ":"F"},
	"17":{"od":1, "do":9, "speed":2, "typ":"F"},
	"18":{"od":2, "do":6, "speed":0, "typ":"A"},
	"19":{"od":2, "do":9, "speed":0, "typ":"A"}
}

func _ready():
	lvl = str(int(name.split("_")[1]))
	
	$Sprite.self_modulate = global_env.color_base
	$Description.set_global_position(get_node("../DescriptionPosition").global_position)
	$Description.visible = false

	$Description/Level.text = str("Level ", lvl)

	$Description/Keyboard.od = level_def[str(lvl)]["od"]
	$Description/Keyboard.do = level_def[str(lvl)]["do"]
	$Description/Keyboard.draw()
	
	if level_def[str(lvl)]["typ"] == "E":
		$Description/Range.text = str(level_def[str(lvl)]["od"], " - ", level_def[str(lvl)]["do"])
	elif level_def[str(lvl)]["typ"] == "A":
		$Description/Enemies.rect_scale = Vector2(0.7,0.7)
		$Description/Enemies.set_position(Vector2(40, 300))
		$Description/Enemies2.rect_scale = Vector2(0.7,0.7)
		$Description/Enemies2.set_position(Vector2(40, 350))
		$Description/Range.rect_scale = Vector2(0.6,0.6)
		$Description/Range.set_position(Vector2(45, 400))
		var pom_r1 = level_def[str(lvl)]["od"] - 1
		var pom_r2 = level_def[str(lvl)]["do"] - 1
		$Description/Range.text = str(pom_r1, " - ", pom_r2, "         ", pom_r1, " - ", pom_r2)
	else:
		$Description/Range.visible = false
	
	
	if level_def[str(lvl)]["speed"] < 2:
		$Description/Speed/TextureRect3.modulate = Color(0.5, 0.5, 0.5)
	if level_def[str(lvl)]["speed"] < 1:
		$Description/Speed/TextureRect2.modulate = Color(0.5, 0.5, 0.5)

func _on_Level_mouse_entered():
	$Sprite.self_modulate = global_env.color_light # highlight hexagon
	$Description.visible = true

func _on_Level_mouse_exited():
	$Sprite.self_modulate = global_env.color_base # remove highlight from hexagon
	$Description.visible = false

func _on_Level_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			global_env.level = lvl
			if get_tree().change_scene("res://screen.tscn") != OK:
				print("Error loading scene res://screen.tscn")
