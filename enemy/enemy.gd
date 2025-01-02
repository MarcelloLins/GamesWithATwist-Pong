extends CharacterBody2D

const SPEED :float = 1.0
var ball: CharacterBody2D

@onready var yOffset = position.y
@onready var flickerDeadzone = 25

var motion :Vector2

func _ready() -> void:
	motion = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	# depending on the instantiation order, ball may not be available in the first physics frame.
	# this prevents NPEs
	if !ball:
		check_and_update()
		return
	# Is the ball higher or lower than the enemy on the Y axis?
	var normalizedYDelta = (ball.position.y - (position.y - yOffset))
	if abs(normalizedYDelta) <= flickerDeadzone:
		return

	if normalizedYDelta < 0:
		motion = Vector2(0, -1 * SPEED)
	elif normalizedYDelta > 0:
		motion = Vector2(0, 1 * SPEED)

	# Y movement is limited to up and down, we won't move diagonally
	#move_and_collide(motion)

func check_and_update():
	var balls = get_tree().get_nodes_in_group("balls")
	if balls.size() > 0:
		ball = balls[0]
