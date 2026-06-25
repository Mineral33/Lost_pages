extends Sprite2D





func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if area.get_parent() is Player:
		#print(area.get_parent().direction)
		if area.get_parent().direction == 1:
			$AnimationPlayer.play("left_to_right")
		elif area.get_parent().direction == -1 :
			$AnimationPlayer.play("right_to_left")
