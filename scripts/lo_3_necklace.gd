extends Node2D
var max_health = 125
var max_shield = 250
var active = 1
func _ready() -> void:
#	$Healthbar.hide()
	pass	
func die():
	get_parent().die()
	
