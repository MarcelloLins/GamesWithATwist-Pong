extends Node2D

@onready var timer :Timer = $"./Timer"
@onready var label :Label = $"./Label"

signal end_game()

var timeLeft: int
func _ready() -> void:
	timeLeft = 30 # seconds
	label.text = str(timeLeft)
	timer.timeout.connect(update_label)

func update_label():
	timeLeft -= 1
	if timeLeft == 0:
		emit_signal("end_game")
		timer.stop()
		return
	label.text = str(timeLeft)
	# restart timer
	timer.start()
