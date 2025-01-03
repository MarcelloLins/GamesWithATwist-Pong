extends Node2D

@onready var ballScene = preload("res://ball/ball.tscn")
@onready var scoreBoundaries = $"../ScoreBoundaries"
@onready var gameTimer :Node2D = $"../Timer"

var _ball: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Spanws a new ball in the world
	_ball = ballScene.instantiate()
	get_parent().call_deferred("add_child", _ball)

	# Score events - Spanws a new ball
	scoreBoundaries.player_scored.connect(_on_scored)
	scoreBoundaries.enemy_scored.connect( _on_scored)

	# Game Timer event - Ends game
	gameTimer.end_game.connect(stop_ball)
	

func stop_ball():
	_ball.stop()

func _on_scored(ball: Node2D):
	# ignores nodes that aren't the ball (in case two collision areas merge and result in the player paddle being received here)
	if !ball.is_in_group("balls"):
		return

	ball.queue_free()
	# Respawn Ball
	_ball = ballScene.instantiate()
	get_parent().call_deferred("add_child", _ball)
