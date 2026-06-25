extends CharacterBody2D
var max_health = 350
var max_shield = 1000
var attack_timer = 0
var blesk = load("res://scenes/enemies/blesk_motyl.tscn")
var c = 0
var distance = 300
var distance_traveled = 0
var direction = 1
var base_y
var base_x
var active = 1
var default_marker_position
@export var type = 1
var bolts =[ preload("res://assets/enemies/motyl/blesk_motyl/blesk_motyl0000.png"),preload("res://assets/enemies/motyl/blesk_motyl/blesk_motyl0001.png"),preload("res://assets/enemies/motyl/blesk_motyl/blesk_motyl0002.png"),preload("res://assets/enemies/motyl/blesk_motyl/blesk_motyl0003.png"),preload("res://assets/enemies/motyl/blesk_motyl/blesk_motyl0004.png"),preload("res://assets/enemies/motyl/blesk_motyl/blesk_motyl0005.png"),preload("res://assets/enemies/motyl/blesk_motyl/blesk_motyl0006.png")]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	$AnimationPlayer.play("fly")
	base_y = global_position.y
	base_x = global_position.x
	default_marker_position = $attack_marker.position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	##print(get_tree().get_nodes_in_group("bolt").size())
	attack_timer += delta
	if ($enemy_health_component.health != max_health or $enemy_health_component.shield != max_shield) and attack_timer > 5 :
		#for bolt in (get_tree().get_nodes_in_group("bolt")):
		#	bolt.queue_free()
		attack_timer = 0
		var opt = 1
		match type:
			1: opt = [2,3,5,4,7,8].pick_random()
			2: opt = [4].pick_random()
			
			
		if opt == 1: #
			$AnimationPlayer2.play("charge1")
			await get_tree().create_timer(1).timeout
			bolt_attack_1()
			await  get_tree().create_timer(1).timeout
			bolt_attack_5()
			await get_tree().create_timer(0.5).timeout
			bolt_attack_4()
		if opt == 2:
			$AnimationPlayer2.play("charge2")
			await get_tree().create_timer(1).timeout
			bolt_attack_5()
			await get_tree().create_timer(0.5).timeout
			bolt_attack_5()
			await get_tree().create_timer(0.5).timeout
			bolt_attack_5()
			await get_tree().create_timer(0.5).timeout
			bolt_attack_5()
			await get_tree().create_timer(0.5).timeout
			bolt_attack_5()
			await get_tree().create_timer(0.5).timeout
		if opt == 3:
			$AnimationPlayer2.play("charge2")
			await get_tree().create_timer(1).timeout
			bolt_attack_3()
		
		if opt == 4:
			$AnimationPlayer2.play("charge1")
			await get_tree().create_timer(1).timeout
			bolt_attack_4()
			await get_tree().create_timer(0.5).timeout
			bolt_attack_4()
			await get_tree().create_timer(0.5).timeout
		if opt == 5:
			$AnimationPlayer2.play("charge1")
			await get_tree().create_timer(1).timeout
			for i in range(12):
				bolt_attack_6()
				if i == 2 or i == 5 or i == 8 :
					bolt_attack_7()
				await get_tree().create_timer(0.1).timeout
				
		if opt == 6:
			$AnimationPlayer2.play("charge1")
			await get_tree().create_timer(1).timeout
			for i in range(3):
				bolt_attack_8()
				await get_tree().create_timer(1.2).timeout
		if opt == 7:
			$AnimationPlayer2.play("charge1")
			await get_tree().create_timer(1).timeout
			for i in range(12):
				bolt_attack_9()
				await get_tree().create_timer(0.2).timeout
			bolt_attack_7()
		if opt == 8:
			$AnimationPlayer2.play("charge1")
			await get_tree().create_timer(1).timeout
			for i in range(12):
				bolt_attack_11()
				await get_tree().create_timer(0.2).timeout
			bolt_attack_7()
func _physics_process(delta: float) -> void:
	##print(c,PI, c>PI)
	##print(direction)
	
	c += delta
	
	if direction == 1:
		$Sprite2D.scale.x = 1
		$attack_marker.position = default_marker_position
		#$Sprite2D.flip_h = false
		#$Sprite2D/Sprite2D.flip_h = false
	elif direction == -1:
		$Sprite2D.scale.x = -1
		$attack_marker.position = -default_marker_position
		#Sprite2D.flip_h = true
		#$Sprite2D/Sprite2D.flip_h = true

	if abs(global_position.x - base_x) >= distance:
		direction *= -1.0
		
		
	c += delta *0.8
	var target_y = base_y + sin(c) * 100
	var velocity = Vector2(direction*2, target_y - global_position.y)
	move_and_collide(velocity)
	
	
func die():
	var loot = randi_range(5,8)
	GameManager.update_log_info('Fly was defeated + '+str(loot)+' wind metal')
	GameManager.drop_wind[2] += loot
	#get_parent().npc_died(self)
	queue_free()
	
	
func bolt_attak_static(angle_degrees):
	var dir = Vector2.DOWN.rotated(deg_to_rad(angle_degrees))
	var offset = 0.0
	var previous_bolt = null
	var stop = true
	var stop_1 = true
	var i = 0
	while stop:
		i += 1
		var bolt = blesk.instantiate()
		bolt.direction = dir
		bolt.texture = bolts.pick_random()
		
		bolt.global_position = $attack_marker.global_position + dir * offset
		get_parent().add_child(bolt)
		
		
		if not is_instance_valid(self) or not is_inside_tree():
			return
		await get_tree().physics_frame  # wait for physics to update overlaps
		if not is_instance_valid(self) or not is_inside_tree():
			return
		await get_tree().physics_frame  # two frames to be safe
		if not is_instance_valid(self) or not is_inside_tree():
			return
			
	
		if !stop_1:
			stop = false
		if bolt.ground():
			stop_1 = false  # stop, we hit the wall
		if i == 15:
			stop= false
		offset += 45.0
		
func bolt_attak_target(dir,inaccuracy):
	#var dir = Vector2.DOWN.rotated(deg_to_rad(angle_degrees))
	var offset = 0.0
	var previous_bolt = null
	var stop = true
	var stop_1 = true
	var stop_2 = true
	while stop:
		  # higher = more spread, 0 = perfect aim
		
		var spread = Vector2(
			randf_range(-inaccuracy, inaccuracy),
			randf_range(-inaccuracy, inaccuracy)
		)
		dir = (dir + spread).normalized()
		
		var bolt = blesk.instantiate()
		bolt.direction = dir
		bolt.texture = bolts.pick_random()
		
		bolt.global_position = $attack_marker.global_position + dir * offset
		get_parent().add_child(bolt)
		
		
		if not is_instance_valid(self) or not is_inside_tree():
			return
		await get_tree().physics_frame  # wait for physics to update overlaps
		if not is_instance_valid(self) or not is_inside_tree():
			return
		await get_tree().physics_frame  # two frames to be safe
		if not is_instance_valid(self) or not is_inside_tree():
			return
			
		if !stop_2:
			stop = false
		if !stop_1:
			stop_2 = false
		if bolt.ground():
			stop_1 = false  # stop, we hit the wall
		
		offset += 45.0
func get_angle_to_player():
	var player = get_parent().get_child(1)
	##print(player)
	var direction = (player.global_position - $attack_marker.global_position).normalized()
	var angle_rad = direction.angle()
	var angle_deg = rad_to_deg(angle_rad)
	##print(angle_deg)
	return direction
	
func bolt_attack_1():
		var delay= 0.05
		bolt_attak_static(15)
		await  get_tree().create_timer(delay).timeout
		bolt_attak_static(10)
		await  get_tree().create_timer(delay).timeout
		bolt_attak_static(20)
		await  get_tree().create_timer(delay).timeout
		
		bolt_attak_static(45)
		await  get_tree().create_timer(delay).timeout
		bolt_attak_static(50)
		await  get_tree().create_timer(delay).timeout
		bolt_attak_static(40)
		await  get_tree().create_timer(delay).timeout
		
		bolt_attak_static(-15)
		await  get_tree().create_timer(delay).timeout
		bolt_attak_static(-10)
		await  get_tree().create_timer(delay).timeout
		bolt_attak_static(-20)
		await  get_tree().create_timer(delay).timeout
		
		bolt_attak_static(-40)
		await  get_tree().create_timer(delay).timeout
		bolt_attak_static(-50)
		await  get_tree().create_timer(delay).timeout
		bolt_attak_static(-45)
		
func bolt_attack_5():
		await  get_tree().create_timer(0.1).timeout
		bolt_attak_static(90)
		bolt_attak_static(80)
		bolt_attak_static(100)
		await  get_tree().create_timer(0.1).timeout
		bolt_attak_static(-90)
		bolt_attak_static(-100)
		bolt_attak_static(-80)

		
func bolt_attack_2():
	
		bolt_attak_static(0)
		await  get_tree().create_timer(0.1).timeout
		bolt_attak_static(30)
		await  get_tree().create_timer(0.1).timeout
		bolt_attak_static(-30)
		
func bolt_attack_3():
	bolt_attak_static(0)
	await  get_tree().create_timer(0.1).timeout
	bolt_attak_static(30)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(60)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(90)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(120)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(150)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(180)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(210)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(240)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(270)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(300)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(330)
	await  get_tree().create_timer(0.1).timeout

	bolt_attak_static(360)
	
func bolt_attack_4():
	bolt_attak_target(get_angle_to_player(), 0.05)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_target(get_angle_to_player(),0.05)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_target(get_angle_to_player(),0)

func bolt_attack_6():
	bolt_attak_static(0)
	#bolt_attak_static(90)
	#bolt_attak_static(-90)
	#bolt_attak_static(180)

func bolt_attack_7():
	bolt_attak_target(get_angle_to_player(),0.02)
func bolt_attack_8():
	bolt_attak_static(45)
	bolt_attak_static(-45)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_static(60)
	bolt_attak_static(-60)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_static(75)
	bolt_attak_static(-75)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_static(90)
	bolt_attak_static(-90)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_static(75)
	bolt_attak_static(-75)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_static(60)
	bolt_attak_static(-60)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_static(45)
	bolt_attak_static(-45)
	await  get_tree().create_timer(0.05).timeout
	
func bolt_attack_9():
	bolt_attak_static(90)
	bolt_attak_static(-90)
	
func bolt_attack_10():
	bolt_attak_static(40)
	bolt_attak_static(-40)
	bolt_attak_static(140)
	bolt_attak_static(-140)
	await  get_tree().create_timer(0.1).timeout
	bolt_attak_static(35)
	bolt_attak_static(-35)
	bolt_attak_static(145)
	bolt_attak_static(-145)
	await  get_tree().create_timer(0.1).timeout
	bolt_attak_static(30)
	bolt_attak_static(-30)
	bolt_attak_static(150)
	bolt_attak_static(-150)
	await  get_tree().create_timer(0.1).timeout
	bolt_attak_static(25)
	bolt_attak_static(-25)
	bolt_attak_static(155)
	bolt_attak_static(-155)
	await  get_tree().create_timer(0.1).timeout
	bolt_attak_static(20)
	bolt_attak_static(-20)
	bolt_attak_static(160)
	bolt_attak_static(-160)
	await  get_tree().create_timer(0.05).timeout
	bolt_attak_static(15)
	bolt_attak_static(-15)
	bolt_attak_static(165)
	bolt_attak_static(-165)

func bolt_attack_11():
	bolt_attak_static(45)
	bolt_attak_static(-45)
	bolt_attak_static(135)
	bolt_attak_static(-135)
