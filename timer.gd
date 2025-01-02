extends Node2D

@onready var timer :Timer = $"./Timer"
@onready var label :Label = $"./Label"

var timeLeft: int
func _ready() -> void:
	timeLeft = 60 # seconds
	label.text = str(timeLeft)
	timer.timeout.connect(update_label)

func update_label():
	timeLeft -= 1
	label.text = str(timeLeft)
	# restart timer
	timer.start()
