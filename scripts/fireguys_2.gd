extends Node2D



var is_here = false
var lock = false
var type = 0
			
func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("go_to") and is_here or Input.is_action_pressed("go_to") and is_here) and !lock:
		#print('open')
		match type:
			
			0: get_parent().get_child(0).fireguys_2_init()
			1:get_parent().get_child(0).fireguys_3_init()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
