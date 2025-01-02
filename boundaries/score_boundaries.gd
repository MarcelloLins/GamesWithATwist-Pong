extends Node2D

@onready var playerBoundary = $"PlayerBoundary"
@onready var enemyBoundary = $"EnemyBoundary"

# signal enemy_scored()
signal player_scored(body: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerBoundary.connect("body_entered", _on_body_entered_player_boundary)
	pass

func _on_body_entered_player_boundary(body: Node2D):
	emit_signal("player_scored", body)