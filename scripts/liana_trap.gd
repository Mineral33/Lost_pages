extends Node2D
@export var trap_time = 2


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().liana_trap(trap_time)
		$AnimationPlayer.play("trap")
		await get_tree().create_timer(trap_time).timeout
		queue_free()
