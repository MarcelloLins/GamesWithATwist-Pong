extends Node2D

@onready var ballScene = preload("res://ball/ball.tscn")
@onready var scoreBoundaries = $"../ScoreBoundaries"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Spanws a new ball in the world
	var ball = ballScene.instantiate()
	get_parent().call_deferred("add_child", ball)

	scoreBoundaries.connect("player_scored", _on_scored)
	scoreBoundaries.connect("enemy_scored", _on_scored)

func _on_scored(ball: Node2D):
	# ignores nodes that aren't the ball (in case two collision areas merge and result in the player paddle being received here)
	if !ball.is_in_group("balls"):
		return

	ball.queue_free()
	# Respawn Ball
	var newBall = ballScene.instantiate()
	get_parent().call_deferred("add_child", newBall)
