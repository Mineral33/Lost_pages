extends Node2D
var max_health = 800
var  max_shield = 1200
var active = true
var markers = []
var projectile_scene = preload("res://scenes/projectiles/lo_1/lo_p_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	markers = [$Marker2D,$Marker2D2,$Marker2D3,$Marker2D4,$Marker2D5,$Marker2D6,$Marker2D7,$Marker2D8]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(is_here_1)
	#print(is_here_2)
	pass
	
	
	
func die():
	# instantiate second phase
	
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
	if is_here_1:
		player.take_damage(25,'m','frozen')
func damage_player_2():
	if is_here_2:
		player.take_damage(25,'m','frozen')
func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here_1 = true
		player = area.get_parent()
func _on_attack_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here_1 = false
		player = null
func _on_attack_area_2_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here_2 = true
		player = area.get_parent()
func _on_attack_area_2_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here_2 = false
		player = null
var order = [1,1,1,1,2,2,1,1,1,1,2,2,3,3,1,1,1,1,2,3,3,3,1,1,1,1,3,1,2,3,1,3,3]
var inaccuracy_degrees = 25
var projectile_type= 1
var order_position =  0
func fire_projectile():
	projectile_type = order[order_position]
	match projectile_type:
		1: 
			$ProjTimer.wait_time = 0.1 
			projectile_type = 1
			inaccuracy_degrees = 25
		2:
			$ProjTimer.wait_time = 0.4
			projectile_type = 2
			inaccuracy_degrees = 15
		3:
			$ProjTimer.wait_time = 0.5
			projectile_type = 3
			inaccuracy_degrees = 5
	var proj = projectile_scene.instantiate()
	get_tree().current_scene.add_child(proj)
	var randi = randi_range(0,7)
	proj.global_position = markers[randi].global_position
	var direction = Vector2(0,1)
	var spread_radians = deg_to_rad(randf_range(-inaccuracy_degrees, inaccuracy_degrees))
	direction = direction.rotated(spread_radians)
	proj.fire(direction, 0,projectile_type) 
	order_position +=1
	if order_position == len(order):
		order_position = 0
func _on_proj_timer_timeout() -> void:
	fire_projectile()
	
