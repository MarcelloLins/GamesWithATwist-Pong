extends Node2D

var playerScore :int
var enemyScore :int

@onready var playerLabel :Label = $"./Player"
@onready var enemyLabel :Label  = $"./Enemy"

# Emits signals when either player or oponent scores
@onready var scoreBoundaries = $"../ScoreBoundaries"

func _ready() -> void:
	scoreBoundaries.connect("player_scored", _update_player_score)
	scoreBoundaries.connect("enemy_scored", _update_enemy_score)

func _update_player_score(_body: Node2D):
	playerScore += 1
	playerLabel.text = str(playerScore)

func _update_enemy_score(_body: Node2D):
	enemyScore += 1
	enemyLabel.text = str(enemyScore)

