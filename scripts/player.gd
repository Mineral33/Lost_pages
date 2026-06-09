extends CharacterBody2D
class_name Player
@onready var animation = $AnimationPlayer
@onready var telo = $telo
@onready var nohy = $nohy
var charging := false
var charge_time := 0.0
const MIN_CHARGE_TIME := 0.3  
var health_armor_multiplyier = 1
var shield_armor_multiplyier = 1
var meele_armor_multiplyier = 1
var magic_armor_multiplyier = 1
var facing_right = true
var SPEED = 330.0
const JUMP_VELOCITY = -500.0
@export var attak_bool = false
var magic_element: int = 0
var meele_element: int = 0
var equiped_necklace = 0
var minimum_charge = 1
var projectile_damage = 5
@export var attaking = false
var shd = true
var max_health = 50
var base_max_health = 50
var health = 51
var shield = 20
var max_shield = 200
var base_max_shield = 200
var can_take_damege = true
@export var hit = false 
var can_move = 1
var dead = 0
var momentum : int
var meele : bool = true
var vlocka = preload("res://scenes/projectiles/vlocka.tscn")
var pr_speed = 500
var fire_rate =1
@onready var fire_rate_timer = $FireRateTimer
var self_momentum = 3
@export var coyote_time: float = 0.15
var coyote_timer: float = 0
var blocked = false
var block_time = 0
var magic_upgrade = [GameManager.magic_ice_upgrade,GameManager.magic_earth_upgrade,GameManager.magic_fire_upgrade, GameManager.magic_wind_upgrade]
var magic_unlocked: bool
var staff= [preload("res://assets/player/staffs/staff4.png"),preload("res://assets/player/staffs/staff8.png"),preload("res://assets/player/staffs/staff5.png"),preload("res://assets/player/staffs/staff2.png")]
var stamina = 100
var fear = 0
var wisdom = 0
var fly_time = 1.8
var current_fly_time = 0
var damage_fly_time = 0
var land_damage_rate = 20
var in_fight = false
var staff_deequip = false
var flat_health_bonus = 0
var flat_shield_bonus = 0
var flat_magic_bonus = 0
var F = 5
var A = 8
var h = 2.5
var sigma = 1.1
var slash_hit = false
var stab_finished = true
var bolt_counter = 0
var bolt = preload("res://scenes/bolt.tscn")
var fall_damage_bool = false
var jump_bool = false
var direction  :float = 0.0
const ACCELERATION = 25.0  # lower = more momentum/slippery
var FRICTION = 35.0
var water = false
var oxygen = 100

var caj_hp = 0
var caj_shd = 0
var caj_kuz = 0
var caj_me_A = 0 
var caj_me_F = 0

var food_hp = 0
var food_shd = 0
var food_kuz = 0
var food_me_A = 0
var food_me_F = 0
var food_FR = 0

var AB_timer_b = true
var ice_ab_b = false
var earth_ab_b = false
var fire_ab_b= false
var wind_ab_b = false
var pierce_ab_b = false
var ab_cd = 0
var magic_change = false

var ab_ui_active = true
var charge_meele_passive = false
func _ready():
	floor_stop_on_slope = true
	motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
	floor_max_angle = deg_to_rad(75)
	floor_snap_length = 10.0 
	wall_min_slide_angle = deg_to_rad(180.0)
	activate_food()
	#invisibility_activate()
#	GameManager.autosave()
	
	#print('caje ', GameManager.caje)
	
	A = GameManager.meele_variables[0]
	F = GameManager.meele_variables[1]
	h = GameManager.meele_variables[2]
#	rojectile_damage = GameManager.magic_variables[0]
	fire_rate = GameManager.magic_variables[1]
	pr_speed = GameManager.magic_variables[2]
	sigma = GameManager.meele_variables[3]
	base_max_health = GameManager.base_health
	base_max_shield = GameManager.base_shield
	#$AnimationPlayer.playback_process_mode = AnimationPlayer.ANIMATION_PROCESS_PHYSICS
	$Camera2D.zoom = Vector2(2,2)
	#$RegenTimer.start()
	var S = GameManager.load_save()
	#magic_weapeon_equip(S[0],magic_upgrade[magic_element-1])
	#print('equim=pment ',GameManager.equiped_meele, GameManager.equiped_necklace, GameManager.equiped_staff)
	#print('active weapeom : ',S[1])
	
	
	neckleace_equip(GameManager.equiped_necklace)
	magic_weapeon_equip(GameManager.equiped_staff)
	meele_weapeon_equip(GameManager.equiped_meele)
	#print(S[0])
	
	health = S[3]
	shield = S[4]
	meele = S[5]
#	print('me/ku: ', meele)
	if !meele and magic_unlocked:
		
		animation.play('kuzlo_idle')
		$ruka/weapeon.show()
		$ruka.texture = preload("res://assets/mec/ruka (2).png")
	#get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,shd)
	else:
		animation.play('meele_idle')
		$ruka/weapeon.hide()
	#health = max_health
	GameManager.player = self
	update_stats()
	#$Camera2D.limit_bottom = 1000
	#meele_weapeon_equip(meele_weapeon)
	#print(max_shield)
	#if	GameManager.player_position_save != null:
	#	print(GameManager.player_position_save)
	#	position = GameManager.player_position_save
		
	#print("ready done: ", name)
func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.pressed:
		#print(get_viewport().gui_get_focus_owner())
		#print(get_viewport().get_mouse_position())
		#
		#var mouse = get_viewport().get_mouse_position()
		#print(get_tree().root.get_child_count())
		#for child in get_tree().root.get_children():
		#	print(child.name)
		#if get_viewport().gui_is_dragging():
		#	return
		pass
func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		attak_bool = true
	if event.is_action_pressed("ability_2"):
		match equiped_necklace: 
			5:invisibility_activate()
			6:critical_invincibility()
		
	
	
	
	
	
var i = 0
func _process(delta):
	#print(get_stack())
	#print( !dead ,' ',  GameManager.magic_unlocked ,' ', !meele)
#   print(meele)
#	print(equiped_necklace,' ',in_air_passive,' ',perfeciton)
	#print(perfeciton)
	#print(equiped_necklace)
	#print($ruka/weapeon.visible)
	#print(block_time)
	#print(projectile_damage,' ',fire_rate,' ', pr_speed,' ',A,' ',F,' ',h,' ',sigma)
	#print(stab_finished)
	#print($IsFightingTimer.time_left)
	#print($IsFightingTimer.is_stopped())
	# $AnimationPlayer.seek($AnimationPlayer.current_animation_position + 1.0 / fps, true)
	#print(meele)
	#print(water)
	#print(meele)
	#if i < 30:
	#	i += 1
	#if i == 30:
	#	i = 0
	#	print($AB_Timer.time_left)
	if ab_ui_active:
		get_parent().get_child(0).update_ab_cd($AB_Timer.time_left, ab_cd)
		if $AB_Timer.is_stopped():
			ab_ui_active = false
			
	if position.y > 2500 and !water:
		get_parent().get_node('UImanager').blackout(2, delta)
		#print('above 2500')
	elif position.y < 2500 and !water:
		get_parent().get_node('UImanager').undo_blackout(2, delta)
	
	if position.y > 2200 and water:
		get_parent().get_node('UImanager').blackout(0.15, delta)
		#('above 2500')
	elif position.y < 2200 and water:
		get_parent().get_node('UImanager').undo_blackout(0.15, delta)
	
	
	
	if Input.is_action_just_pressed("Switch") and $Timer_switch.is_stopped() :
		meele = !meele
	#	print('switched meele ',meele)
		if meele:
			meele_weapeon_equip(meele_element)
			$ruka/weapeon.hide()
			match meele_element:
				0:
					animation.play('meele_idle')
				1:
					animation.play('ice_meele_idle')
				2:
					animation.play('earth_meele_idle')
				3:
					animation.play('fire_meele_idle')
				4:
					animation.play('wind_meele_idle')
				5:
					animation.play('wind_meele_idle')
				6:
					animation.play('wind_meele_idle')
		#elif !meele and GameManager.magic_unlocked:
			#magic_upgrade = [GameManager.magic_ice_upgrade,GameManager.magic_earth_upgrade,GameManager.magic_fire_upgrade, GameManager.magic_wind_upgrade]
			#print(magic_element)
			#print(magic_upgrade[magic_element-1])
			#print(magic_element,magic_upgrade[magic_element-1])
			#print(magic_element)
		#	print('proces mage equip')
			#magic_weapeon_equip(magic_element)
		#	animation.play('kuzlo_idle')
			#$ruka/weapeon.show()
		else:
			magic_weapeon_equip(magic_element)
			$ruka/weapeon.hide()
			animation.play('kuzlo_idle')
		$Timer_switch.start(5)
	if meele and !dead and attak_bool:	
		#print("meele ",meele_weapeon)
		if Input.is_action_pressed('block'):
			if not blocked:
				match meele_element:
					0:
						animation.play("block")	
					1:
						animation.play('ice_block')
					2:
						animation.play('earth_block')
					3:
						animation.play('fire_block')
					4:
						animation.play('wind_block')
					5:
						animation.play('wind_block')
					6:
						animation.play('wind_block')
		
			block_time += delta
			blocked = true
		else:
			self_momentum = 3
			if blocked:
				match meele_element:
					0:
						animation.play("meele_idle")
					1:
						animation.play('ice_meele_idle')
					2:
						animation.play('earth_meele_idle')
					3:
						animation.play('fire_meele_idle')
					4:
						animation.play('wind_meele_idle')
					5:
						animation.play('wind_meele_idle')
					6:
						animation.play('wind_meele_idle')
				blocked = false
				block_time = 0
		# charged and fast attak
		if Input.is_action_pressed("attack"):
			if not charging:
				charging = true
				charge_time = 0.0
			else:
				charge_time += delta
				#print(charge_time)
				if charge_time > 0.3:
					start_charge_animation()
				if charge_meele_passive and charge_time > 1.5:
					charge_damage(charge_time)
		elif charging:
			# Button was released
			charging = false
			stop_charge_animation()
			if charge_meele_passive:
				momentum = calculate_momentum_ch_p(charge_time)
				last_t = 1.5
				
			elif slow_down_charge:
				momentum = calcutale_momentum_sd_p(charge_time)
			else:
				momentum = calculate_momentum(charge_time)
		#	print(stab_finished)
			if charge_time >minimum_charge:
				attak()
			elif stab_finished:
				
				stab()
				stab_finished = false
	
			charge_time = 0.0
	elif !dead and  GameManager.magic_unlocked and !meele:
		var element = GameManager.equiped_staff
		$ruka/weapeon.show()
		animation.play('kuzlo_idle')
		#print(meele)
		if element == 0:
			$ruka/weapeon.hide()
		if Input.is_action_pressed('attack') and fire_rate_timer.is_stopped():
			if fire_rate and projectile_damage and pr_speed:
				projektil()
				fire_rate_timer.start() 
		#print('here')		
		if Input.is_action_just_pressed('block') and AB_timer_b:
			match element:
				1:
					ice_ab()
					
				2:
					hp_ab()
				3:
					fire_ab()
				4:
					wind_ab()
				5:
					pierce_ab()
				6:
					teleport_ab()	
				7:
					AoE_ab()
			#magic attak
	
	elif staff_deequip:
		$ruka/weapeon.hide()
		animation.play('kuzlo_idle')
	#if $IsFightingTimer.is_stopped():
	
var inaccuracy = 0.05
var drunk = false
func drink():
	inaccuracy += 0.1
	FRICTION = 10
	drunk = true
	InputMap.action_erase_events("left")
	InputMap.action_erase_events("right")
	
	var left_event = InputEventKey.new()
	left_event.keycode = KEY_D
	InputMap.action_add_event("left", left_event)
	
	var right_event = InputEventKey.new()
	right_event.keycode = KEY_A
	InputMap.action_add_event("right", right_event)
	
func vytriezvi():
	inaccuracy = 0.0 
	FRICTION = 35
	drunk = false
	InputMap.action_erase_events("left")
	InputMap.action_erase_events("right")
	
	var left_event = InputEventKey.new()
	left_event.keycode = KEY_A
	InputMap.action_add_event("left", left_event)
	
	var right_event = InputEventKey.new()
	right_event.keycode = KEY_D
	InputMap.action_add_event("right", right_event)
		
func projektil():
	invisibility_deactivate()
#	print(GameManager.magic_ice_upgrade)
	if magic_element == 0:
		$ruka/weapeon.hide()
		return
	fire_rate_timer.wait_time = fire_rate-food_FR
	$IsFightingTimer.start()
	
	var project = vlocka.instantiate()
	get_parent().add_child(project)
	project.type(magic_element)
	project.global_position = $ruka/AttakArea/SwordTip.global_position
	project.element = magic_element
	#print("kuzlo")
	project.range = 300 
	if pierce_ab_b:
		project.pierce = 4
	project.projectile_damage = (projectile_damage + food_kuz + inaccuracy*10) * perfeciton
	project.speed = pr_speed
	  # adjust this
	var spread = Vector2(
		randf_range(-inaccuracy, inaccuracy),
		randf_range(-inaccuracy, inaccuracy)
	)
	var direction = (get_global_mouse_position() - global_position).normalized()
	project.velocity = (direction + spread).normalized() * project.speed
	

	
func start_charge_animation():
	if not animation.is_playing() or animation.current_animation != "charge":
		match meele_element:
			0:
				animation.play("charge")
			1:
				animation.play('ice_charge')
			2:
				animation.play('earth_charge')
			3:
				animation.play('fire_charge')
			4,5,6:
				animation.play('wind_charge')
		
func stop_charge_animation():
	if animation.is_playing():
		animation.stop()
var drunk_movement = 0
var up_drunk =1
var drunk_movement_switch = false
var drunk_movement_switch_last = false
func _physics_process(delta: float) -> void:
	#print($AB_Timer.time_left)
	if (Input.is_action_pressed("left") or  Input.is_action_pressed("right") ) and !slow_down_charge:
		SPEED +=25
		if SPEED > 400:
			SPEED = 400
	elif (Input.is_action_pressed("left") or  Input.is_action_pressed("right") ) and slow_down_charge:
		var max_slow_down_SPEED = 400 - charge_time *75
		if max_slow_down_SPEED <= 0:
			max_slow_down_SPEED = 10
		SPEED +=25
		if SPEED > max_slow_down_SPEED:
			SPEED = max_slow_down_SPEED
	#	print(max_slow_down_SPEED)
	else:
		SPEED = 0
	if Input.is_action_pressed("down"):
		position.y += 2
		
	if Input.is_action_pressed("left"):
		telo.scale.x = abs(telo.scale.x)*-1
		nohy.scale.x = abs(nohy.scale.x)*-1
		
	if Input.is_action_pressed("right"):
		telo.scale.x = abs(telo.scale.x)
		nohy.scale.x = abs(nohy.scale.x)
	
	# Add the gravity. 	
	if not is_on_floor() and !water:
		velocity += get_gravity() * delta*1.2
	elif not is_on_floor() and water:
		velocity += get_gravity() * delta*1.2  *0.1
		
	if is_on_floor():
		coyote_timer = coyote_time  # reset timer when grounded
	else:
		coyote_timer -= delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and coyote_timer > 0.0:
		
		if water:
			velocity.y = lerp(velocity.y, JUMP_VELOCITY*3, ACCELERATION * delta*0.3) * can_move
		elif drunk:
			velocity.y = lerp(velocity.y, JUMP_VELOCITY*2.8* randf_range(0.5,1.1), ACCELERATION * delta) * can_move
		else:
			velocity.y = lerp(velocity.y, JUMP_VELOCITY*2.8, ACCELERATION * delta) * can_move
			
		coyote_timer = 0.0
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.4
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = 0.0
	if Input.is_action_pressed("left"):
		direction = -1
	if Input.is_action_pressed("right"):
		direction = 1
	

	if direction and can_move:
	#	print('moving')
		if water:
			velocity.x = lerp(velocity.x, direction * SPEED*0.3, ACCELERATION * delta*0.3)
		elif drunk:
			
			#print('movement mult ',drunk_movement, 'up', up_drunk,'low',low_drunk)
			if drunk_movement > up_drunk :
				drunk_movement -= delta
				drunk_movement_switch = true
			elif drunk_movement < up_drunk:
				drunk_movement += delta
				drunk_movement_switch = false
			if drunk_movement_switch != drunk_movement_switch_last :
				up_drunk = randf_range(0.4,1)
				
		
			velocity.x = lerp(velocity.x, direction * SPEED*drunk_movement , ACCELERATION * delta )
			drunk_movement_switch_last = drunk_movement_switch
		else:
			velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION * delta)

			
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION * delta*0.3)

	if !is_on_floor() and !water:
		current_fly_time += delta
		if current_fly_time > fly_time:
			#print('fly time ', current_fly_time, ' ', fly_time)
			damage_fly_time += delta 
			fall_damage_bool = true
		
			
	elif fall_damage_bool:
		fall_damage_bool = false
		current_fly_time = 0
		take_damage(max_health * inverse_lerp(0,0.5,damage_fly_time),"m",'Fell')
	#	print('fly damage il : ', inverse_lerp(0,0.5,damage_fly_time))
		damage_fly_time = 0
	else:
			current_fly_time = 0
	# Optional: smooth stop when no input
	if direction == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.1)
		
		
	if velocity.x > 0:
		facing_right = true
	elif velocity.x < 0:
		facing_right = false

	#if !$up_sutostep_raycast.is_colliding() && $down_autostep_raycast.is_colliding():
	#	position.y -= 20
	#	if facing_right:
	#		position.x += 2
	##	else:
	#		position.x -= 2
	
	update_animation()
	move_and_slide()
	if position.y >=10000 and !dead:
		die('Fell')
		
func attak():
	attaking = true
	match meele_element:
		0:
			animation.play("stab")  # You can rename this to "charged_attack" if needed
			
		1:
			animation.play('ice_slash')
		2:
			animation.play('earth_slash')
		3:
			animation.play('fire_slash')
		4:
			animation.play('wind_slash')
		5,6:
			animation.play('wind_slash')

func stab():
	attaking = true
	match meele_element:
		0:	
			animation.play('stab')
		1:
			animation.play('ice_stab')
		2:
			animation.play('earth_stab')
		3:
			animation.play('fire_stab')
		4,5,6:
			animation.play('wind_stab')

	momentum = 2
func start_slash():
	slash_hit = false
	
func attack_action():
	invisibility_deactivate()
	
	#print(slash_hit)
	$IsFightingTimer.start()
	if in_air_passive:
		check_in_air_passive()
	if !slash_hit:
		# preco do riti element  0 nefunguje? ani neregistruje npc
		var overlapping_objects = $ruka/AttakArea.get_overlapping_areas()
		for area in overlapping_objects:
	
			var parent = area.get_parent()
			#print('yes')
			if parent.is_in_group("Enemies") and area.name == 'hurtbox':
				var meele_damage = round((momentum + F + food_me_F)*perfeciton *in_air_passive_multiliper)
				#print("Hit: " + parent.name+ " dmg  "+str(momentum)+' + '+ str(F) )
				if parent.get_parent().name== 'červ':
					parent = parent.get_parent()
				match meele_element:
					0,1,5,6:
						parent.find_child("enemy_health_component", true, false).take_damage_enemy((meele_damage), 'm')
					
					2:
					#	shield += round((round(momentum)+F))
						parent.find_child("enemy_health_component", true, false).take_damage_enemy(meele_damage, 'm')
					3:
						parent.find_child("enemy_health_component", true, false).take_damage_enemy((meele_damage), 'mf')
					4:
						bolt_counter += 1
						parent.find_child("enemy_health_component", true, false).take_damage_enemy(meele_damage, 'm')
						if bolt_counter > 3:
							parent.find_child("enemy_health_component", true, false).take_damage_enemy(bolt_counter*3, 'm')
							var effect = bolt.instantiate()
							effect.global_position = parent.global_position
							get_tree().current_scene.add_child(effect)
						#	print('charges '+str(bolt_counter)+' *3 = '+str(bolt_counter*3))
							bolt_counter = 0
			
				slash_hit = true
				#Charged attack deals more damage
			elif parent is Barrel:
				parent.destroy()
			
func stab_action():
	$IsFightingTimer.start()
	var overlapping_objects = $ruka/AttakArea.get_overlapping_areas()
	invisibility_deactivate()
	if in_air_passive:
		check_in_air_passive()
	for area in overlapping_objects:
	#	print(area.get_parent())	
		var parent = area.get_parent()
		if parent.get_parent().name== 'červ':
					parent = parent.get_parent()
		if parent.is_in_group("Enemies") and area.name == 'hurtbox':
		#	print("Hit: " + parent.name+ " dmg  "+str(F)) 
			var meele_damage = round((F+food_me_F) *perfeciton *in_air_passive_multiliper)
		#	print(meele_element)
			match meele_element:
				0,1,2,5,6:
					parent.find_child("enemy_health_component", true, false).take_damage_enemy(meele_damage, 'm')
				3 :
					parent.find_child("enemy_health_component", true, false).take_damage_enemy(meele_damage, 'mf')
				4 :
					bolt_counter += 1
					parent.find_child("enemy_health_component", true, false).take_damage_enemy(meele_damage, 'm')
				
					
			#Charged attack deals more damage
		elif parent is Barrel:
			parent.destroy()
			
func charge_animation_reset():
	animation.play("meele_idle")
	
func show_charge_effect(ratio: float):
	# For example, update a progress bar or glow sprite
	pass

func calculate_momentum(t):
	return (A+food_me_A)* exp(-pow(t - h, 2) / (2 * pow(sigma, 2)))
func calculate_momentum_ch_p(t):
	return (3*t)**2  
func calcutale_momentum_sd_p(t):
	#print((A+food_me_A+5)* exp(-pow(t*0.2 -1.4, 2) / (2 * pow(sigma-0.5, 2))))
	return (A+food_me_A+5)* exp(-pow(t*0.2 -1.4, 2) / (2 * pow(sigma-0.5, 2)))
func update_animation():
	#if attaking or charging:
		#return  # Don't interrupt attack
	#print(direction)

	if velocity.y < 0:
		$walk.play("jump")
	elif velocity.y > 0:
		$walk.play("fall")
	elif direction != 0.0:
		$walk.play("walk")
	elif direction == 0:
		$walk.play("ilde")

func take_damage(damage_amount: int, type,cause, enemy_momentum:=INF, bypass:=''):
	# kazdy frame nieco dava 0 dmg
	#print('take damege ',damage_amount,' ', type,' ', enemy_momentum)
	if invincibility and !bypass:
		return
	$IsFightingTimer.start()
	if damage_amount == 0:
		return
	#$IsFightingTimer.start()
	damage_amount = round(damage_amount)
	if type == 'm':	
		if blocked:
		#	
		#	print('take damage: self '+str(self_momentum)+' enemy '+str(enemy_momentum))
		#	print(damage_amount)
			# print(clamp(inverse_lerp(0,2,block_time)/2,0,0.5))
			iframes()
			health -= damage_amount - damage_amount * clamp(inverse_lerp(0,2,block_time)/2,0,0.5)
		elif can_take_damege:
			health -= damage_amount
	if type == 'p':
		
		if meele_element == 1 and blocked:
			damage_amount = damage_amount*0.2
		
		if shield - damage_amount > 0 :
			#print('shield damaged')
			if !ice_ab_b:
				
				$shield_damaged.play('shied_damaged')
				shield -= damage_amount
			else:
				shield -= damage_amount/2
		
		elif shield - damage_amount <= 0 and shield >0:
			if !ice_ab_b:
				$shield_damaged.play('shied_damaged')
				damage_amount -= shield
				shield = 0
				health -= damage_amount
			else:
				damage_amount -= shield
				shield = 0
				#health -= damage_amount
		
		else:
			if !ice_ab_b:
				health -= damage_amount
			else:
				health -= damage_amount/2
			hit = true
			
	check_if_perfection()
	check_for_invincibility_triger()
	$damage_number_display.display_took_damage_player(damage_amount)
	get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,shd)
	get_parent().get_child(0).get_child(9).update_healthbar(health,max_health,shield,max_shield,shd)
	
	if health <= 0 and !dead:
		die(cause)
	
func iframes():
	can_take_damege = false
	await get_tree().create_timer(1).timeout
	can_take_damege = true
	
func die(cause):
	dead = 1
	can_move = 0
	get_parent().get_child(0).death_ui(cause)
	#GameManager.respawn_player()
	#get_node("Healthbar").update_healthbar(health,max_health)
	#animation.play("idle")
	

func magic_weapeon_equip(magic_weapeon_local: int):
	#print($ruka.visible)
	var level =0
	print(' new equip mag ', magic_weapeon_local)
	#$ruka/weapeon.show()
	magic_element = magic_weapeon_local
	if magic_element == 0:
		staff_deequip = true
		return
	else:
		staff_deequip = false
	if !meele:	
		animation.play('kuzlo_idle')
		$ruka/weapeon.show()
		
#	print(magic_element)
	match magic_element:
		1:
			$ruka/weapeon.texture = preload("res://assets/player/staffs/staff4.png")
		2:
			$ruka/weapeon.texture = preload("res://assets/player/staffs/staff8.png")
		3:
			$ruka/weapeon.texture = preload("res://assets/player/staffs/staff5.png")
		4:
			$ruka/weapeon.texture = preload("res://assets/player/staffs/staff2.png")
		5:
			$ruka/weapeon.texture = preload("res://assets/player/staffs/staff3.png")
		6:
			$ruka/weapeon.texture = preload("res://assets/player/staffs/staff1.png")
		7: 
			$ruka/weapeon.texture = preload("res://assets/player/staffs/staff6.png")
	update_ab_ui()
	get_parent().get_node('UImanager').update_ab_icon(magic_element)
func meele_weapeon_equip(me):
#	
	print(' meele equip ', me)
	meele_element = me
	charge_meele_passive = false
	match meele_element:
		0:
			if meele:
				$AnimationPlayer.play('meele_idle')
		1:
			if meele:
				$AnimationPlayer.play('ice_meele_idle')
		2:
			if meele:
				$AnimationPlayer.play('earth_meele_idle')
			earth_meele_passive_heal()
		3:
			if meele:
				$AnimationPlayer.play('fire_meele_idle')
		4:
			if meele:
				$AnimationPlayer.play('wind_meele_idle')
		5: 
			if meele:
				$AnimationPlayer.play('wind_meele_idle')
			charge_meele_passive = true
		6:
			if meele:
				$AnimationPlayer.play('wind_meele_idle')
			slow_down_charge_activate()
			
			
	F = GameManager.meele_variables[1]		
	if meele:
		$ruka/weapeon.hide()
	else:
		$ruka/weapeon.show()
		animation.play('kuzlo_idle')
	update_stats()
func neckleace_equip(type):
	#print(type)
	equiped_necklace = type
	if type == 0:
		$necklace.hide()
		reset_multipliers()
		
		return
	$necklace.show()
	if type == 1:
		$necklace.texture = preload("res://assets/player/necklaces/necklace - ice.png")
		reset_multipliers()
		shield_armor_multiplyier = 1.5
	elif type == 2:
		$necklace.texture = preload("res://assets/player/necklaces/necklace - earth.png")
		reset_multipliers()
		health_armor_multiplyier = 1.5
	elif type == 3: 
		$necklace.texture = preload("res://assets/player/necklaces/necklace - fire.png")
		reset_multipliers()
		health_armor_multiplyier = 1.5
	elif type == 4:
		$necklace.texture = preload("res://assets/player/necklaces/necklace - wind.png")
		reset_multipliers()
		meele_armor_multiplyier = 1.5
	elif type == 5:
		$necklace.texture = preload("res://assets/player/necklaces/necklace - ice gold.png")
		reset_multipliers()
	elif type == 6:
		$necklace.texture = preload("res://assets/player/necklaces/necklace - earth gold.png")
		reset_multipliers()
	elif type == 7:
		$necklace.texture = preload("res://assets/player/necklaces/necklace - fire gold.png")
		perfection_bonus()
		in_air_passive_deactivate()
		check_if_perfection()
	elif type == 8:
		$necklace.texture = preload("res://assets/player/necklaces/necklace - wind gold.png")
		#perfection_bonus()
		perfection_nonactive()
		in_air_passive_activate()
	
	
	update_food_hp()
	update_food_shd()
	update_food_kuz()
	update_food_me_A()
	update_food_me_F()
	update_stats()
	#health = max_health
	#shield = max_shield
	#get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,shd)
func reset_multipliers():
		shield_armor_multiplyier = 1
		health_armor_multiplyier = 1
		magic_armor_multiplyier = 1
		meele_armor_multiplyier = 1
		perfection_nonactive()
		in_air_passive_deactivate()
	
# gravity inflicted pick up drops from barrels
#multiple joint arm(?) replacable weapeon, magic wand, bow, magic shield
# complec AI with damage mostly from big swings, not static hitbox, targeting player not general area, combo attaks,
# exp gain, exp wisdom drops and save, shop, character item UI, abilities
# maps, random gen(?), nice look, world building, stroytelling

func _on_regen_timer_timeout() -> void:
	#print('yes')
	if $IsFightingTimer.is_stopped() and !dead:
		if health < max_health:
			heal(max_health/12)
		if health > max_health:
			pass
			
		if shield < max_shield:
			heal_shield(max_shield/12)
		if shield > max_shield:
			pass
		update_stats()

func update_stats():
	max_health = base_max_health  + flat_health_bonus +food_hp
	max_shield = base_max_shield  + flat_shield_bonus +food_shd
	if max_health<health:
		health = max_health
	if max_shield<shield:
		shield = max_shield
		
	get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,shd)
	get_parent().get_child(0).get_child(9).update_healthbar(health,max_health,shield,max_shield,shd)
	

func stab_reset():
	await get_tree().create_timer(0.7).timeout
	stab_finished = true
	
	
	
func earth_meele_passive_heal():
	while meele_element == 2 and meele and !dead:
		await get_tree().create_timer(5).timeout
		heal(10)
		update_stats()
		$meele_passive_heal_efect.play('meele_passive_heal_effect')


func liana_trap(trap_time):
	can_move = 0
	await get_tree().create_timer(trap_time).timeout
	if !dead:	
		can_move = 1
		
func poison(poison_tick_damage ,tick_time, ticks,cause):
	for i in range(0,10):
		take_damage(poison_tick_damage, 'm',cause)
		await get_tree().create_timer(tick_time).timeout
'''		
 weapeon ideas: uses shield to heal, penetrates, projectiles uses own health
'spectrum' ability, poison, lighting magic chrge, health on enemy kill, full heal,
shield weakness, speed, shield used as hp for certain time, lower health - higher damage,
projectile reflection, 

vvšeobecné kúzla nie elementy
 earth meele passive efect
 shield damage visual efect
'''
func in_water():
	water = true
	
	$ruka/weapeon.modulate = Color("#74acff")
	$ruka.modulate = Color("#74acff")	
	$necklace.modulate = Color("#74acff")

	$effect.modulate = Color("#74acff")
	$telo.modulate = Color("#74acff")
	$nohy.modulate = Color("#74acff")
	velocity.y = velocity.y/3
	$other_hand.modulate = Color("#74acff")
	while water:
		$oxbar.show()
		oxygen -=2
		await get_tree().create_timer(0.3).timeout
		if oxygen < 0:
			take_damage(round(max_health/25),'m','blub blub blub')
		$oxbar.update_oxbar(oxygen, 100)
func out_water():
	water = false
	
	$ruka/weapeon.modulate = Color("#ffffff")
	$ruka.modulate = Color("#ffffff")	
	$necklace.modulate = Color("#ffffff")
	$effect.modulate = Color("#ffffff")
	$telo.modulate = Color("#ffffff")
	$nohy.modulate = Color("#ffffff")
	$other_hand.modulate = Color("#ffffff")
	if velocity.y < 0:  # still moving up
		velocity.y = JUMP_VELOCITY * can_move
	while !water and oxygen <= 100:
		await get_tree().create_timer(0.1).timeout
		oxygen += 3
		$oxbar.update_oxbar(oxygen, 100)
		if oxygen >= 100:
			await get_tree().create_timer(1).timeout
			$oxbar.hide()
func heal(amount):
	#print('heal')
	amount =  floor(amount)
	health +=  amount
	if health > max_health:
		health = max_health
	update_stats()
	check_for_invincibility_triger()
	check_if_perfection()
	$damage_number_display.display_took_heal(amount)
func heal_shield(amount):
#	print('shd heal')
	amount =  floor(amount)
	shield += amount
	if shield > max_shield:
		shield = max_shield
	update_stats()
	$damage_number_display.display_took_heal_shield(amount)
func caj_up():
	caj_shd = 200
	update_food_shd()
func caj_dych(): 
	caj_hp = 75
	update_food_hp()
func caj_det():
	caj_kuz = 5
	update_food_kuz()
func caj_poz():
	caj_me_A = 5
	caj_me_F = 5
	update_food_me_A()
	update_food_me_F()
	
var kalerab_A = 0
func kalerab():
	kalerab_A = 3
	update_food_me_A()
var vlocky_HP = 0
func vlocky():
	vlocky_HP = 50
	update_food_hp()
var ryza_SHD = 0
func ryza():
	ryza_SHD = 100
	update_food_shd()
var kurca_P =0
func kurca():
	kurca_P = 2
	update_food_kuz()
var koleno_HP = 0
func koleno():
#	print('koleno')
	koleno_HP = 50
	update_food_hp()
var mlieko_SHD = 0
func mlieko():
	mlieko_SHD = 100
	update_food_shd()
var yogurt_kuz = 0
func yogurt():
	yogurt_kuz = 3
	update_food_kuz()
var parenica_n_A =0
func parenica_n():
	parenica_n_A = 5
	update_food_kuz()
var parenica_u_me_F =0
func parenica_u():
	parenica_u_me_F = 3
	update_food_me_F()
func update_food_shd():
	food_shd =  (caj_shd+ ryza_SHD +mlieko_SHD)   *shield_armor_multiplyier
	update_stats()
	return food_shd
func update_food_hp():
	#print('cak hp ',caj_hp, 'vlocky ',vlocky_HP,' koleno ', koleno_HP, 'neck',health_armor_multiplyier)
	food_hp = (caj_hp+ vlocky_HP +koleno_HP)    *health_armor_multiplyier
	update_stats()
	return food_hp
func update_food_kuz():
	food_kuz = (caj_kuz + kurca_P + yogurt_kuz)   *magic_armor_multiplyier
	update_stats()
	return food_kuz
func update_food_me_A():
	food_me_A = (caj_me_A+ kalerab_A +parenica_n_A)   *meele_armor_multiplyier
	update_stats()
	return food_me_A
func update_food_me_F():
	food_me_F =(caj_me_F + parenica_u_me_F)   *meele_armor_multiplyier
	update_stats()
	return food_me_F
var FR_multiplier= 1
func update_food_FR():
	food_FR = (0)* FR_multiplier
func activate_food():
	if GameManager.caje[0]:
		caj_up()
	if GameManager.caje[1]:
		caj_dych()
	if GameManager.caje[2]:
		caj_det()
	if GameManager.caje[3]:
		caj_poz()
		
	if GameManager.food_bought[2]:
		kalerab()
	if GameManager.food_bought[3]:
		vlocky()
	if GameManager.food_bought[1]:
		ryza()
	if GameManager.food_bought[0]:
		kurca()
	if GameManager.food_bought[4]:
		koleno()
	if GameManager.food_bought[5]:
		mlieko()
	if GameManager.food_bought[6]:
		yogurt()
	if GameManager.food_bought[7]:
		parenica_n()
	if GameManager.food_bought[8]:
		parenica_u()
func ice_ab():
	AB_timer_b = false
	ice_ab_b = true
	ab_cd = 7
	$AB_Timer.wait_time = ab_cd
	$AB_Timer.start()
	update_ab_ui()
	$shield_damaged.play('shield_ab')
	await  get_tree().create_timer(2).timeout
	ice_ab_b = false
	$shield_damaged.play("shied_damaged")
	
func hp_ab():
	earth_ab_b = true
	AB_timer_b = false
	health = max_health
	ab_cd = 7
	$AB_Timer.wait_time = ab_cd
	$AB_Timer.start()
	update_ab_ui()
	$heal_ab.play("heal_ab")
	update_stats()
	earth_ab_b=false
	
	
func _on_ab_timer_timeout() -> void:
	AB_timer_b = true
	
func reset_ab_timer():
#	print('reseting timer ', GameManager.AB_time_left)
	$AB_Timer.wait_time = GameManager.AB_time_left
	$AB_Timer.start()
	update_ab_ui()
	
	
func fire_ab():
	AB_timer_b = false
	fire_ab_b = true
	var old_fire_rate= fire_rate
	var old_damage = projectile_damage
	fire_rate = 0.02
	projectile_damage = round(old_damage/2)
	inaccuracy = 0.25
	ab_cd = 7
	$AB_Timer.wait_time = ab_cd
	$AB_Timer.start()
	update_ab_ui()
	await get_tree().create_timer(1.5).timeout
	fire_rate = old_fire_rate
	projectile_damage =old_damage
	inaccuracy = 0.05
	fire_ab_b = false
	
func pierce_ab():
	AB_timer_b = false
	pierce_ab_b = true
	var old_fire_rate= fire_rate
	fire_rate = fire_rate - 0.1
	ab_cd = 7
	$AB_Timer.wait_time = ab_cd
	$AB_Timer.start()
	update_ab_ui()
	await get_tree().create_timer(2.5).timeout
	fire_rate = old_fire_rate
	pierce_ab_b = false
	
func wind_ab():
	wind_ab_b = true
	ab_cd = 7
	$AB_Timer.wait_time = ab_cd
	$AB_Timer.start()
	update_ab_ui()
	AB_timer_b = false
	wind_ab_b = true
	GameManager.wind_ab_b = true
	await get_tree().create_timer(5).timeout
	wind_ab_b = false
	GameManager.wind_ab_b = false
	wind_ab_b = false
var teleport_efect = preload("res://scenes/effects/teleport_efefct.tscn")
func teleport_ab():
	var te_inst = teleport_efect.instantiate()
	te_inst.global_position = global_position
	get_parent().add_child(te_inst)
	global_position = get_global_mouse_position()
	AB_timer_b = false
	ab_cd = 7
	$AB_Timer.wait_time = ab_cd
	$AB_Timer.start()
	update_ab_ui()
	te_inst = teleport_efect.instantiate()
	te_inst.global_position = global_position
	get_parent().add_child(te_inst)
	
	
var bomb = preload('res://scenes/projectiles/bomb_player.tscn')
func AoE_ab():
	var bomb_inst = bomb.instantiate()
	
	get_parent().add_child(bomb_inst)
	bomb_inst.global_position = $ruka/AttakArea/SwordTip.global_position
	  # adjust this
	var spread = Vector2(
		randf_range(-inaccuracy, inaccuracy),
		randf_range(-inaccuracy, inaccuracy)
	)
	var direction = (get_global_mouse_position() - global_position).normalized()
	
	bomb_inst.fire((direction + spread).normalized(),500)
	AB_timer_b = false
	ab_cd = 7
	$AB_Timer.wait_time = ab_cd
	$AB_Timer.start()
	update_ab_ui()
	
func update_ab_ui():
	ab_ui_active = true
	
#func update_ab_ui():

func randomize_bindings():
	var actions = ["left", "right", "jump", "down", "go_to", "switch", "attack", "block"]
	
	var keys = [KEY_W, KEY_A, KEY_S, KEY_D, KEY_E, KEY_R]
	
	var mouse_actions = ["attack", "block"]
	var mouse_buttons = [MOUSE_BUTTON_LEFT, MOUSE_BUTTON_RIGHT]
	
	keys.shuffle()
	
	var key_index = 0
	for action in actions:
		InputMap.action_erase_events(action)
		
		if action in mouse_actions:
			var event = InputEventMouseButton.new()
			var picked = mouse_buttons.pick_random()
			event.button_index = picked
			mouse_buttons.erase(picked)
			InputMap.action_add_event(action, event)
		else:
			var event = InputEventKey.new()
			event.keycode = keys[key_index]
			key_index += 1
			InputMap.action_add_event(action, event)
		
		#print(action, " -> ", InputMap.action_get_events(action))
func restore_bindings():
	var defaults = {
		"left":   [KEY_A],
		"right":  [KEY_D],
		"jump":   [KEY_W],
		"down":   [KEY_S],
		"go_to":  [KEY_R],
		"switch": [KEY_E],
		"attack": [MOUSE_BUTTON_LEFT],
		"block":  [MOUSE_BUTTON_RIGHT],
	}
	
	for action in defaults:
		InputMap.action_erase_events(action)
		for key in defaults[action]:
			if key in [MOUSE_BUTTON_LEFT, MOUSE_BUTTON_RIGHT]:
				var event = InputEventMouseButton.new()
				event.button_index = key
				InputMap.action_add_event(action, event)
			else:
				var event = InputEventKey.new()
				event.keycode = key
				InputMap.action_add_event(action, event)
	#	print(action, " -> ", InputMap.action_get_events(action))
		
#	for i in range((ab_cd+2)*50):
		#print($AB_Timer.time_left)
#		get_parent().get_child(0).update_ab_cd($AB_Timer.time_left ,ab_cd)
#		await get_tree().create_timer(1/50).timeout
	#while $AB_Timer.time_left:
		#get_parent().get_child(0).update_ab_icon($AB_Timer.time_left ,ab_cd)
var last_t = 1.5
func charge_damage(t):
	if t - last_t > 0.2:
		take_damage(round((t)**2) ,'m','lets go',INF,'bypass')
		last_t = t
var invincibility = false
func check_for_invincibility_triger():
	if float(health)/float(max_health) < 0.2:
		critical_invincibility()
func critical_invincibility():
	invincibility = true
	for j in range(2):
		for i in range(25):
			$ruka.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
			$ruka/weapeon.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
			$necklace.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
			$nohy.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
			$telo.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
			$other_hand.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
			await get_tree().create_timer(0.01).timeout
		for i in range(25):
			$ruka.modulate.a = move_toward($ruka.modulate.a,1,0.02)
			$ruka/weapeon.modulate.a = move_toward($ruka.modulate.a,0.75,0.02)
			$necklace.modulate.a = move_toward($ruka.modulate.a,1,0.02)
			$nohy.modulate.a = move_toward($ruka.modulate.a,1,0.02)
			$telo.modulate.a = move_toward($ruka.modulate.a,1,0.02)
			$other_hand.modulate.a = move_toward($ruka.modulate.a,1,0.02)
			await get_tree().create_timer(0.01).timeout
		heal(5)
		heal_shield(10)
	invincibility = false

var  invisibility = false
func invisibility_activate():
	invisibility = true
	for i in range(25):
		set_collision_layer_value(1, false) 
		$HitBox.set_collision_layer_value(1, false) 
		$ruka.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
		$ruka/weapeon.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
		$necklace.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
		$nohy.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
		$telo.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
		$other_hand.modulate.a = move_toward($ruka.modulate.a,0.50,0.02)
func invisibility_deactivate():
	invisibility = false
	for i in range(25):
		set_collision_layer_value(1, true)
		$HitBox.set_collision_layer_value(1, true)  
		$ruka.modulate.a = move_toward($ruka.modulate.a,1,0.02)
		$ruka/weapeon.modulate.a = move_toward($ruka.modulate.a,0.75,0.02)
		$necklace.modulate.a = move_toward($ruka.modulate.a,1,0.02)
		$nohy.modulate.a = move_toward($ruka.modulate.a,1,0.02)
		$telo.modulate.a = move_toward($ruka.modulate.a,1,0.02)
		$other_hand.modulate.a = move_toward($ruka.modulate.a,1,0.02)
		await get_tree().create_timer(0.01).timeout
var perfeciton = 1			
var perfecition_active = false
func perfection_bonus():
	perfeciton = 1.25
	perfecition_active = true
	#print('perfection bonus')
func perfection_unbonus():
	perfeciton = 0.9
	
#	print('perfection unbonus')
func perfection_nonactive():
	perfeciton = 1
	perfecition_active = false
#	print('perfection nonactive')
			
func check_if_perfection():
	#print('h/mh ',health,' ',max_health,' ',float(health)/float(max_health))
	if perfecition_active:
		if float(health)/float(max_health) < 0.9:
			
			perfection_unbonus()
		else:
			perfection_bonus()
var in_air_passive_multiliper = 1
var in_air_passive = false
func check_in_air_passive():
	if !is_on_floor():
		in_air_passive_multiliper = 1.2 + current_fly_time
	#	print(current_fly_time)
		
	else:
		in_air_passive_multiliper = 1
func in_air_passive_activate():
		in_air_passive = true
func in_air_passive_deactivate():
		in_air_passive = false

var slow_down_charge = false
func slow_down_charge_activate():
	slow_down_charge = true
func slow_down_charge_deactivate():
	slow_down_charge = false
	
