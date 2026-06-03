extends Node2D
@export var path_to_level = "res://scenes/levely/lad.tscn"
@export var player_spawn = 201
var is_here = null
func _on_area_2d_area_entered(area: Area2D) -> void:
	is_here = true
	if area.get_parent() is Player and is_here:
		if Input.is_action_pressed("go_to")or Input.is_action_just_pressed("go_to"):
			GameManager.save()
			GameManager.spawn = player_spawn
			GameManager.enter_level(path_to_level)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = null
