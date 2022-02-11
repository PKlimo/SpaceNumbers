extends Area2D

var target
var speed = 1000
var direction = Vector2()

func _ready():
	global_position = Vector2(77+10, 300+112)
	$start.play()
	pass

func _physics_process(delta):
	if not is_instance_valid(target):
		queue_free()
	else:
		direction = global_position.direction_to(target.global_position)
		direction = direction.normalized() 
		global_rotation = direction.angle()
	
		position += direction *speed * delta
