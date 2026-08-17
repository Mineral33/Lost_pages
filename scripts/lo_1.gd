extends Node2D
var max_health = 800
var  max_shield = 1200
var active = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(is_here_1)
	print(is_here_2)
	
	
	
	
func die():
	queue_free()

func _on_stump_timer_1_timeout() -> void:
	$AnimationPlayer.play("stumb")
	$stump_timer_1.wait_time = randfn(5.0, 2.0) 

func _on_stump_timer_2_timeout() -> void:
	$AnimationPlayer2.play("stumb")
	$stump_timer_2.wait_time = randfn(5.0, 2.0) 
	
var is_here_1 = false
var is_here_2 = false	
var player = null

func damage_player_1():
	if is_here_2:
		player.take_damage(25,'m','frozen')
func damage_player_2():
	if is_here_1:
		player.take_damage(25,'m','frozen')
			

func _on_attack_area_area_entered(area: Area2D) -> void:

	if area.get_parent() is Player:
		is_here_1 = true
		player = area.get_parent()

func _on_attack_area_area_exited(area: Area2D) -> void:
	if area.get_parent() == Player:
		is_here_1 = false
		player = null

func _on_attack_area_2_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here_2 = true
		player = area.get_parent()
func _on_attack_area_2_area_exited(area: Area2D) -> void:
	if area.get_parent() == Player:
		is_here_2 = false
		player = null
