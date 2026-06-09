extends Area2D

#@export var linear_damp = 5.0
#@export var gravity_scale = 0.3

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and area.name == 'head':
		area.get_parent().in_water()


func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player and area.name == 'head':
		area.get_parent().out_water()
