extends Node2D



func _on_jump_pad_area_area_entered(area: Area2D) -> void:
	print(area.get_parent())
	if area.get_parent() is Player:
		var player = area.get_parent()
		if player.velocity.y >= 0:
			player.velocity.y = -max(abs(player.velocity.y) * 0.95, 500)
