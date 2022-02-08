extends Node2D

var wait:float = 0.0
var sound:bool = false

func _ready():
	randomize()
	rotation_degrees = rand_range(0, 360)
	
	yield(get_tree().create_timer(wait), "timeout")
	
	if sound:
		$AudioStreamPlayer.play()
	$Animation.play("explosion")
	yield($Animation, "animation_finished") # wait until animation ends
	queue_free() # node sa odstrani az po skonceni animacie

