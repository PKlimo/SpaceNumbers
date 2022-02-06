extends Node2D

var from = Vector2(60,300)
var to = null

func _ready():
	get_node("shield").visible = false

func fire(toA, shield=false):
	get_node("Audio").play()
	if shield:
		get_node("shield").visible = true
		get_node("shield").global_position = toA + Vector2(0,120)
		to = toA - Vector2(50,0) # korekcia, laser sa zastavi pred stitom
	else:
		to = toA

	update() # draw laser
	yield(get_tree().create_timer(0.3), "timeout")
	to = null
	update() # remove laser by setting to to null and calling _draw() via update()

	get_node("shield").visible = false

func _draw():
	if to != null:
		# draw_line(from, to, Color(0.498, 0.721, 1, 1), 3)
		draw_line(from, to, global_env.color_light, 3)
	else:
		draw_line(from, from, Color(0, 0, 0, 0), 1)
