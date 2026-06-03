extends Node2D
@export var max_health = 200
var health
var max_shield = 0
var shield
var active = 1
# Called when the node enters the scene tree for the first time.

func die():
	queue_free()
