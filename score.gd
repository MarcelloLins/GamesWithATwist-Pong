extends Node2D

var playerScore :int
var enemyScore :int

@onready var playerLabel :Label = $"./Player"
@onready var playerTimer :Timer = $Player/Timer
@onready var enemyLabel :Label  = $"./Enemy"
@onready var enemyTimer :Timer = $Enemy/Timer

@onready var shader = preload("res://bouncy.gdshader")

# Emits signals when either player or oponent scores
@onready var scoreBoundaries = $"../ScoreBoundaries"

func _ready() -> void:
	scoreBoundaries.player_scored.connect(_update_player_score)
	scoreBoundaries.enemy_scored.connect(_update_enemy_score)
	
	# shader timers used for animation when a player scores
	playerTimer.timeout.connect(func(): disable_shader(playerLabel))
	enemyTimer.timeout.connect(func(): disable_shader(enemyLabel))

func _update_player_score(_body: Node2D):
	playerScore += 1
	playerLabel.text = str(playerScore)
	_enable_bouncy_shader(playerTimer, playerLabel)

func _update_enemy_score(_body: Node2D):
	enemyScore += 1
	enemyLabel.text = str(enemyScore)
	_enable_bouncy_shader(enemyTimer, enemyLabel)

func _enable_bouncy_shader(timer: Timer, label: Label):
	label.material.set_shader(shader)
	# if stopped, start it
	if timer.is_stopped():
		timer.start()
	else:
		# add more time to it, in case scores overlap before the label animation ends
		timer.stop()
		timer.start()


func disable_shader(label: Label):
	label.material.set_shader(null)
