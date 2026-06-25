extends CharacterBody2D
# attak on sight 
# other enemies - simple enemy projectile target
#boss stacionary 'bullet hell' 
#boss dynamic - spawning small enemies that follow and teleporting between positions
var SPEED = 80.0
var facing_right = true
var dead = false
#var max_health = 80
#var health 
var current_speed = 0
var hit = false
var can_attak = true
@export var attaking = false
#var max_shield= 100
#var shield
@onready var coin
var player
var dir = Vector2.ZERO
@export var max_health = 500
@export var max_shield = 500
var active = 0
var attack_timer = 0
var jump_timer = randf_range(6, 7)
var fall_attack = false
var jump_bool = false
var ref
var fly_follow_timer = 0.0
var area_ref = null
var momentum = 25
func _ready() -> void:
	#shield = max_shield
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	#health= max_health
	$AnimationPlayer.play("idle")
	#area_ref = $attack_area
#	get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
func _process(delta: float) -> void:
	##print(fall_attack,' ',jump_bool)
	##print(jump_timer - attack_timer)
	##print(player)
	##print(player , active , !fall_attack)
	pass
func get_up():
	if is_on_floor():
		$AnimationPlayer.play("get_up")
		await get_tree().create_timer(1).timeout
		active = 1
		_on_attack_area_area_entered(area_ref)
		##print('get up complete')
func _physics_process(delta: float) -> void:
	# Add the gravity.

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#if !$up_autostep_raycat.is_colliding() && $"down_autostep raycast".is_colliding():
		#position.y -= 17
	
	
	
	
	#var ref = $Player_follow_raycast.get_collider()
	
	
	
	if active:
		attack_timer += delta
		
		

	if jump_bool:
		velocity.y -= 450
		jump_bool = false
	##print(ref)
	if  ref == get_parent().get_child(1) and !is_on_floor() and  fly_follow_timer < 0.7:
		
		fly_follow_timer += delta
		dir = ref.global_position.x - global_position.x
		if dir > 5:
			velocity.x = 350
			scale.x = abs(scale.x)
			$attack_area.scale.x = 1
			$Hitbox.scale.x = 1
			$Sprite2D.scale.x = 0.4
			$Hitbox_II.scale.x = 1
		elif dir <-5:
			velocity.x = -350
			scale.x = abs(scale.x)
			$attack_area.scale.x = -1
			$Hitbox.scale.x = -1
			$Sprite2D.scale.x = -0.4
			$Hitbox_II.scale.x = -1
		else:
			velocity.x = 0
	else:
		velocity.x = 0
		
	if ref == get_parent().get_child(1) and active && !attaking && is_on_floor() :
		if !fall_attack:
			$AnimationPlayer.play('walk')
		dir = ref.global_position.x - global_position.x
		if dir > 5:
			dir = 1
			scale.x = abs(scale.x)
			$attack_area.scale.x = 1
			$Hitbox.scale.x = 1
			$Sprite2D.scale.x = 0.4
		elif dir <-5:
			dir = -1
			scale.x = abs(scale.x)
			$attack_area.scale.x = -1
			$Hitbox.scale.x = -1
			$Sprite2D.scale.x = -0.4
		elif is_on_floor():
			dir= 0
			$AnimationPlayer.play("idle")

		velocity.x = dir * SPEED
	elif is_on_floor():
		dir = 0
		velocity.x = 0
	move_and_slide()
	
func atack_action():
	var bodies  = $Hitbox.get_overlapping_bodies()
	for body in bodies:
		if body == player && !dead && can_attak:
			body.take_damage(randf_range(41,53),'m',' asi to neni len hrad', 5)
			
func atack_action_II():
	var bodies  = $Hitbox_II.get_overlapping_bodies()
	for body in bodies:
		if body == player && !dead && can_attak:
			#print('ATTACK II')
			body.take_damage(randf_range(32,38),'m',' asi to neni len hrad', 5)
			
func attack_action_fall():
	var bodies  = $jump_area.get_overlapping_bodies()
	for body in bodies:
		if body is Player && !dead :
			body.take_damage(randf_range(70,101),'m',' pricviknutý', 5)
	fall_attack = false
	active = 0
	fly_follow_timer = 0
	
func die():
	dead = true
	GameManager.update_log_info('Walking fortress defeated + 750 gold, antimonite bar')
	SPEED = 0
	GameManager.gold += 750
	GameManager.smelted_bars[2] += 1
	self.queue_free()
	
	
func _on_attack_area_area_entered(area: Area2D) -> void:
#	#print(area.get_parent())
	if area != null:
		if area.get_parent() is Player && !dead : 	
			##print("-------------------------in----------------------------")
			player = area.get_parent()
			area_ref = area
			while player and active  && !fall_attack:
				if [0,1].pick_random() == 1:
					$AnimationPlayer.play("hand_attak")
					attaking = true
					await get_tree().create_timer(1.5).timeout
					attaking = false
				else :
					$AnimationPlayer.play("attack_II")
					attaking = true
					await get_tree().create_timer(1.5).timeout
					attaking = false
					
func _on_attack_area_area_exited(area: Area2D) -> void:
	##print('out')
	if active && !fall_attack:
		$AnimationPlayer.play('walk')
		
	if area.get_parent() is Player:
		##print(area.get_parent(), ' ', area)
		player = null
		#area_ref = null
	
	
func jump():
	jump_bool = true
	$AnimationPlayer.play('jump')
	fall_attack = true
	active = 0
	await get_tree().create_timer(0.5).timeout
	while !is_on_floor():
		await get_tree().create_timer(0.1).timeout
	$AnimationPlayer.play('jump_impact')
	


func _on_player_follow_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		ref = area.get_parent()
		
		
func _on_player_follow_area_area_exited(area: Area2D) -> void:
	#ref=  null
	pass

func _on_jump_timer_timeout() -> void:
			if active:
				jump()
				$JumpTimer.start(randf_range(7, 8))
			
