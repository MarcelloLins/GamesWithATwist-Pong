extends Node2D

@onready var timer :Timer = $"./Timer"
@onready var announcementTimer :Timer = $"ClearAnnouncement"
@onready var powerupScene = preload("res://powerups/powerup.tscn")

@onready var announcementsPerPowerUp = {
	PowerUp.Type.REWIND: "Rewind!"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(spawn_power_up)
	announcementTimer.timeout.connect(clear_label)
	
func spawn_power_up():
	var power = powerupScene.instantiate()
	power.power_up_activated.connect(update_label)
	get_parent().call_deferred("add_child", power)

func update_label(type: PowerUp.Type):
	$"./Announcement".text = announcementsPerPowerUp[type]
	announcementTimer.start()

func clear_label():
	$"./Announcement".text = ""