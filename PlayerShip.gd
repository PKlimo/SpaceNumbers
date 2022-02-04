extends KinematicBody2D

var direction = Vector2()
var look_direction = Vector2.RIGHT
var speed = 350
var can_move = false

func _physics_process(_delta):
	direction = Vector2(
		Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	)
	if direction.length() > 0.0 and direction != look_direction:
		look_direction = direction
	direction = direction.normalized() * speed
	
	if can_move:	
		move_and_slide(direction)
		get_node("Sprite").global_rotation = look_direction.angle()
	
