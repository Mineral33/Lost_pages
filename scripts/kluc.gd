extends Area2D


@export var door_index = 0

var player = null
var opened_bool = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("go_to") and player != null and !opened_bool:
		
		get_parent().unlock_barier(door_index)
		queue_free()

func opened():
	opened_bool = true

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		player = area.get_parent()

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		player = null
