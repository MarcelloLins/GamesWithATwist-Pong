extends Node2D

@onready var playerBoundary = $"PlayerBoundary"
@onready var enemyBoundary = $"EnemyBoundary"

# signal enemy_scored()
signal player_scored(body: Node2D)
signal enemy_scored(body: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerBoundary.body_entered.connect(_on_body_entered_player_boundary)
	enemyBoundary.body_entered.connect(_on_body_entered_enemy_boundary)

# Signal-based approach to notifying both the ball and score handlers that someone scored
func _on_body_entered_player_boundary(body: Node2D):
	emit_signal("enemy_scored", body)

func _on_body_entered_enemy_boundary(body: Node2D):
	emit_signal("player_scored", body)
