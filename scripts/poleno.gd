extends Node2D
@export var damage = 5
var player_inside: Player = null
func _ready() -> void:
	$AnimationPlayer.play("hori")


func _on_damage_timer_timeout() -> void:
	if player_inside:
		player_inside.take_damage(damage, "m",'páli')


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		player_inside = area.get_parent()
		player_inside.take_damage(damage, "m", 'páli')
		$DamageTimer.start()
		
		
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		player_inside.take_damage(damage, "m",'páli')
		
		player_inside = null
		$DamageTimer.stop()
		
func _on_light_timer_timeout() -> void:
	$PointLight2D.energy = 1.0 + randf_range(-0.15, 0.15)
