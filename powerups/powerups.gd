extends Node2D

@onready var timer :Timer = $"./Timer"
@onready var powerupScene = preload("res://powerups/powerup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(spawn_power_up)

func spawn_power_up():
	var power = powerupScene.instantiate()
	get_parent().call_deferred("add_child", power)