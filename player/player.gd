extends CharacterBody2D


const SPEED :float = 12.0

func _physics_process(_delta: float) -> void:
	var motion :Vector2
	if Input.is_action_pressed("UP"):
		motion.y -= 1 # Positive Y is -1 in Godot
	if Input.is_action_pressed("DOWN"):
		motion.y += 1
	
	move_and_collide(motion * SPEED)