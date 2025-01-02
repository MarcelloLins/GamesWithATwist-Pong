extends CharacterBody2D


const SPEED :float = 7.0

func _physics_process(_delta: float) -> void:
	var motion :Vector2
	if Input.is_action_pressed("UP"):
		motion = Vector2.UP
	if Input.is_action_pressed("DOWN"):
		motion = Vector2.DOWN
	
	move_and_collide(motion * SPEED)