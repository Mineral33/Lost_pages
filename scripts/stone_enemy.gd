extends CharacterBody2D
var health
var max_health = 350
var shield
var max_shield = 150
var land = false
var jump = false
var init = false
var following = false
var dir = 0
var facing_right = true
var dash = false
var previous_facing_right = false
var direction = 0
var dificulty
var gold = 120
var dr = false
var damage = 35
var active = 1
var momentum = 20
var p 

var kamen = preload("res://scenes/projectiles/kameň_projectile.tscn")
func _ready() -> void:
	dificulty = [0.5,0.7,1,1.3,1.5].pick_random()
	max_health = max_health * dificulty
	max_shield  = max_shield * dificulty
	gold = gold * dificulty
	damage = damage * dificulty
func _physics_process(delta: float) -> void:
	if jump:
		position.y += 15
		
		if $RayCast_ground.is_colliding() :
			jump = false
			$AnimationPlayer.play("land")
			var areas_land = $dash_right_area.get_overlapping_areas()
			for area in areas_land:
				if area.get_parent() is Player:
					area.get_parent().take_damage(damage*3,'m',' niečo padlo zo stropu')
					break
			await get_tree().create_timer(1).timeout
			$AnimationPlayer.play("idle")
			scale.y = 0.5
			init = true
			var areas = $player_follow_area.get_overlapping_areas()
		#print('init and fol')
			for area in areas:
				if area.get_parent() is Player:
					_on_player_follow_area_area_entered(area)
					break
	if init:
		velocity += delta*get_gravity()
		
	if init and following:
		var areas = $player_follow_area.get_overlapping_areas()
		#print('init and fol')
		for area in areas:
			if area.get_parent() is Player:
	
				dir = area.get_parent().global_position.x - global_position.x
				
				if dir > 25:
					facing_right = true
					direction = 1
				elif dir < 25:
					facing_right = false
					direction = -1
				else :
					direction = 0
				if previous_facing_right == true and facing_right== false:
					$AnimationPlayer.play("attack_around_left")
				if previous_facing_right == false and facing_right== true:
					$AnimationPlayer.play("attack_around_right")
				
				if !$up_autostep_raycat.is_colliding() && $"down_autostep raycast".is_colliding():
					position.y -= 20
					position.x -= 2
				if !$up_autostep_raycat2.is_colliding() && $"down_autostep raycast2".is_colliding():
					position.y -= 20
					position.x += 2
					
					
				if dash:
					if direction == 1:
						position.x += 5
					elif direction == -1:
						position.x -= 5
					
			
				previous_facing_right = facing_right
	move_and_slide()

func _process(delta: float) -> void:
#	print(	'land ', land,' jump ',jump, ' init ',init,' following ',following )
	if init:
		pass
	
	pass
func _on_init_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !init:
		$AnimationPlayer.play('init')
		await get_tree().create_timer(1).timeout
		$AnimationPlayer.play("jump")
		jump = true
		
func _on_init_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player and !init:
		land = true

# [0,1].pick_random()
func _on_player_follow_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and init:
		following = true
		
		
		
		while following:
			var distance = area.get_parent().global_position - global_position
			var sum = abs(distance.x) + abs(distance.y)
			
			var option = [0].pick_random()
			print(sum)
			if sum > 200 or sum <-200:
				teleport()
			else:
				if option == 0:
					dash_at()
				if option == 1:
					swoosh()
				if option == 2:
					teleport()
			await get_tree().create_timer(2.7).timeout
			

func _on_player_follow_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player and init:
		following = false
		teleport()


func dash_at():
	dash = true
	if facing_right:	
		$AnimationPlayer.play('dash_prep_right')
		await get_tree().create_timer(0.4).timeout
		$AnimationPlayer.play('attack_dash_right')
	else:
		$AnimationPlayer.play('dash_prep_left')
		await get_tree().create_timer(0.4).timeout
		$AnimationPlayer.play('attack_dash_left')
	await get_tree().create_timer(0.7).timeout
	dash = false
	
	
func swoosh():
	if facing_right:
		$AnimationPlayer.play('swoosh_attack_right')
		print('swoosh right')
	else: 
		$AnimationPlayer.play("swoosh_attack_left")
		print('swoosh left')
	pass







func die():
	var loot 
	var random = randi_range(1,9)
	match random:
		1: 
			loot = floor(randi_range(14,25)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' crystal ice')
			GameManager.drop_ice[0] += loot
		2:
			loot =floor( randi_range(4,7)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' giant snowflake')
			GameManager.drop_ice[1] += loot
		3:
			loot = floor(randi_range(1,2)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' frozen core')
			GameManager.drop_ice[2] += loot
		4: 
			loot = floor(randi_range(14,25)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' ash')
			GameManager.drop_fire[0] += loot
		5:
			loot = floor( randi_range(4,7)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' fire in bottle')
			GameManager.drop_fire[1] += loot
		6:
			loot = floor(randi_range(1,2)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' magma')
			GameManager.drop_fire[2] += loot
		7: 
			loot = floor(randi_range(14,25)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' wind feather')
			GameManager.drop_wind[0] += loot
		8:
			loot = floor( randi_range(4,7)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' wind in bottle')
			GameManager.drop_wind[1] += loot
		9:
			loot = floor(randi_range(1,2)*dificulty)
			GameManager.update_log_info('tougher than rock! +'+str(loot)+' wind metal')
			GameManager.drop_wind[2] += loot
	#get_parent().npc_died(self)
	queue_free()

var cause = ' šuter'
func swoosh_damage():
	var areas = $swoosh_area.get_overlapping_areas()
	for area in areas:
		if area.get_parent() is Player:
			area.get_parent().take_damage(damage,'m',cause)
			break

func dash_damage_right():
	var areas = $dash_right_area.get_overlapping_areas()
	for area in areas:
		if area.get_parent() is Player:
			area.get_parent().take_damage(damage,'m',cause)
			break
			
func dash_damage_left():
	var areas = $dash_left_area.get_overlapping_areas()
	for area in areas:
		if area.get_parent() is Player:
			area.get_parent().take_damage(damage,'m',cause)
			break

func teleport():
	p = get_parent().get_node('Player')
	#print(p)
	var project = kamen.instantiate()
	project.parent = self
	project.global_position = global_position
	
	var direction = (p.global_position - global_position).normalized()
	project.velocity = direction * 850
	get_parent().add_child(project)	
	
	

func teleport_hit():
	if p:
		global_position = p.global_position
		p.take_damage(25,'m',' ender perla')


func _on_fall_damage_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and jump:
		area.get_parent().take_damage(damage,'m',cause)
		
