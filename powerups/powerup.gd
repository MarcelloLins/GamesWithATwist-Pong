extends Node2D

@onready var area2D: Area2D = $"./Area2D"
@onready var rewindSprite = preload("res://assets/powerups/Rewind.png")

var _type :PowerUp.Type
@onready var spritesPerType = {
	PowerUp.Type.REWIND: rewindSprite
}

@onready var collisionPerType = {
	PowerUp.Type.REWIND: _ball_collided_rewind
}

signal power_up_activated(type: PowerUp.Type)

func _ready() -> void:
	position = get_random_coordinates()
	# Power Up Type Randomization
	create_random_powerup()

func create_random_powerup():
	# Picks a random type
	_type = PowerUp.Type.values().pick_random()
	# Assigns corresponding sprite
	assign_sprite(_type)
	assign_collision_handler(_type)

func assign_sprite(type: PowerUp.Type):
	var spriteNode : Sprite2D = get_node("./Sprite")
	var sprite = spritesPerType[type]
	spriteNode.texture = sprite

func assign_collision_handler(type):
	var collisionHandler = collisionPerType[type]
	area2D.body_entered.connect(collisionHandler)

func get_random_coordinates():
	randomize()
	var windowSize = get_window().size
	var xOffset = windowSize.x * 0.25 # 25% of the X axis will be dead space so that it doesn't spawn too close to the paddles
	var yOffset = windowSize.y * 0.15 # 15% of the Y axis will be dead space so that it doesn't spawn too close to the edges
	var xFrom = xOffset
	var xTo = windowSize.x - xOffset
	var yFrom = yOffset
	var yTo = windowSize.y - yOffset

	return Vector2(randf_range(xFrom, xTo), randf_range(yFrom, yTo))

# Collision handlers, one per power up type
func _ball_collided_rewind(ball: Node2D):
	# ignores nodes that aren't the ball (power ups can spawn on top of one another)
	if !ball.is_in_group("balls"):
		return
	# Rewinds ball
	ball.rewind()
	# Signals that this was triggered
	emit_signal("power_up_activated", PowerUp.Type.REWIND)

	# destroy ourselves
	queue_free()
