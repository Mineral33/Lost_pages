extends Node2D
var max_health =500
var max_shield = 700
var active = 1
var projectile = preload("res://scenes/projectiles/fg_p_1.tscn")
var inaccuracy_degrees = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func die():
	get_parent().get_node('fire guys').type= 1
	get_parent().get_node('fire guys').lock = false
	
	GameManager.fg_defeat = true
	queue_free()

func fire():
	var proj_inst = projectile.instantiate()
	proj_inst.global_position = $Marker2D.global_position
	get_parent().add_child(proj_inst)

	var direction = (get_parent().get_node('Player').global_position - $Marker2D.global_position).normalized()
	var spread_radians = deg_to_rad(randf_range(-inaccuracy_degrees, inaccuracy_degrees))
	direction = direction.rotated(spread_radians)
	proj_inst.fire(direction, 450,0) 
	


func _on_attack_timer_timeout() -> void:
	var rng = randi_range(0,3)
	match rng:
		0: 
			
			$AttackTimer.start(2)
			$AnimationPlayer.play("fire")
			inaccuracy_degrees= 20
			for i in range(12):
				fire()
				await get_tree().create_timer(0.05).timeout
				
		1:
			$AttackTimer.start(2.8)
			$AnimationPlayer.play("fire")
			inaccuracy_degrees= 4
			for j in range(5):
				for i in range(2):
					fire()
					await get_tree().create_timer(0.05).timeout
				await get_tree().create_timer(0.4).timeout
		2:
			$AttackTimer.start(3.5)
			fw_left()
			await get_tree().create_timer(4).timeout
		3:
			$AttackTimer.start(3.5)
			fw_right()
			await get_tree().create_timer(4).timeout
	
var is_in_r_fw = false
var is_in_l_fw = false

func _on_fw_damage_area_right_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_in_r_fw = true
func _on_fw_damage_area_right_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_in_r_fw = false
func _on_fw_damage_area_left_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_in_l_fw = true
func _on_fw_damage_area_left_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_in_l_fw = false

func fw_r_continue():
	$AnimationPlayer.play("fw_right_idle")
func fw_l_continue():
	$AnimationPlayer.play("fw_left_idle")

func fw_r_damage():
	if is_in_r_fw:
		get_parent().get_node('Player').take_damage(25,'p','crispy')
func fw_l_damage():
	if is_in_l_fw:
		get_parent().get_node('Player').take_damage(25,'p','crispy')
func fw_left():
	$AnimationPlayer.play('fire_wall_left')
	await get_tree().create_timer(3).timeout
#	$FireWallLeft.hide()
	$AnimationPlayer.play("fw_l_out")
	await get_tree().create_timer(1).timeout
func fw_right():
	$AnimationPlayer.play('fire_wall_right')
	await get_tree().create_timer(3).timeout
	#$FireWallRight.hide()
	$AnimationPlayer.play("fw_r_out")
	await get_tree().create_timer(1).timeout
