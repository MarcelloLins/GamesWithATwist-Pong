extends CharacterBody2D

@export var speed :float = 400
var motion :Vector2

# Initial launching of the ball
func _ready() -> void:
	add_to_group("balls")

	# Initial position should be the halfway point of both dimensions of the viewport
	position = Vector2.ZERO

	randomize()
	var random_x = [-1, 1].pick_random()
	var random_y = randf_range(-0.8, 0.8)
	motion = Vector2(random_x, random_y)
	move_and_collide(motion)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(motion * speed * delta)

	# did we collide with anything?
	if collision:
		motion = motion.bounce(collision.get_normal())
