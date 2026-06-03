extends CharacterBody2D
# attak on sight 
# other enemies - simple enemy projectile target
#boss stacionary 'bullet hell' 
#boss dynamic - spawning small enemies that follow and teleporting between positions
var SPEED = 425
var facing_right = true
var dead = false
var max_health = 50
var health 
var current_speed = 0
var hit = false
var can_attak = true
var max_shield= 0
var shield
@onready var coin
var player
var dir = Vector2.ZERO
var ref
var rng := RandomNumberGenerator.new()
var jump_chance
var jump_timer : float
var active = 1
var momentum = 5
func _ready() -> void:

	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	$AnimationPlayer.play("run")
	
	

		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	rng.randomize()
	jump_chance = rng.randf_range(0.0, 1.0)
	jump_timer += delta
	if jump_chance > 0.98 and jump_timer > 1.5:
		velocity.y -= 700
		jump_timer = 0
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !$up_autostep_raycat.is_colliding() && $"down_autostep raycast".is_colliding():
		position.y -= 17
	
	var ref = $player_follow_area.get_overlapping_areas()
	
	
	for i in ref:
		
		if i.get_parent() == get_parent().get_child(1):
			dir = i.global_position.x - global_position.x
	
			if dir > 10:
				
				dir = 1
				scale.x = abs(scale.x)
				$Sprite2D.flip_h = false
				
				facing_right = true
				$up_autostep_raycat.scale.x = abs($up_autostep_raycat.scale.x)
				$"down_autostep raycast".scale.x = abs($"down_autostep raycast".scale.x)
				SPEED += 1
			elif dir <-10:
				dir = -1
				$Sprite2D.flip_h = true
				
				facing_right = false
				$up_autostep_raycat.scale.x = -abs($up_autostep_raycat.scale.x)
				$"down_autostep raycast".scale.x = -abs($"down_autostep raycast".scale.x)
				SPEED += 1
			else:
				dir= 0
				SPEED -= 5
				if SPEED <= 50:
					SPEED = 0
				if SPEED > 425:
					SPEED = 425
			
			
			velocity.x += dir * SPEED/60
		
		else:
			if !$ground_detection_raycast.is_colliding():
				pass
				#print('activated')
				#flip()
			
			
			
			
	move_and_slide()
	'''
func take_damage(damage_amount,type):
	if !dead:
		#$AnimationPlayer.play("hit")
		
		if type == 'm':
			health -= damage_amount
			
		elif type == 'p':
			if shield > 0:
				shield -= damage_amount
			elif shield - damage_amount < 0 and shield >0:
				damage_amount -= shield
				shield = 0
				health -= damage_amount
			elif shield <= 0:
				health -= damage_amount
		elif type == 'w':
			if shield > 0:
				shield -= damage_amount*0.7
				health -= damage_amount*0.5
			elif shield - damage_amount < 0 and shield >0:
				damage_amount -= shield
				shield = 0
				health -= damage_amount
			elif shield <= 0:
				health -= damage_amount
		elif type == 'i':
			if shield > 0:
				shield -= damage_amount
			elif shield - damage_amount < 0 and shield >0:
				damage_amount -= shield
				shield = 0
				health -= damage_amount
			elif shield <= 0:
				health -= damage_amount
		elif type == 'f':
			if shield > 0:
				shield -= damage_amount*1.2
			elif shield - damage_amount < 0 and shield >0:
				damage_amount -= shield
				shield = 0
				health -= damage_amount
			elif shield <= 0:
				health -= damage_amount
		elif type == 'e':
			if shield > 0:
				shield -= damage_amount*1
			elif shield - damage_amount < 0 and shield >0:
				damage_amount -= shield
				shield = 0
				health -= damage_amount
			elif shield <= 0:
				health -= damage_amount
		get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
	if health <= 0:
		die()
		'''    
func get_hit():
	hit =!hit

	if hit:
		current_speed = SPEED
		SPEED = 0
		can_attak = false
	else:
		SPEED = current_speed
		can_attak = true
		$AnimationPlayer.play("run")
		
func flip():
	facing_right = !facing_right
	if facing_right:
		
		scale.x = -abs(scale.x)
	elif !facing_right:
		
		scale.x = abs(scale.x)

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 	
		player = area.get_parent()
		while player != null:
			player.take_damage(10,'m',' strom', 5)
			await get_tree().create_timer(0.5).timeout

	
func die():
	dead = true
	var loot = randf_range(0,2)
	GameManager.update_log_info('dexamet minion was defeated +'+str(loot)+' dense wood')
	SPEED = 0
	GameManager.drop_earth[0]+=loot

	await get_tree().create_timer(0.2).timeout
	#print('info to level '+ str(get_parent().name))# tell game manager that this died
	queue_free()
	#var coin_instance = coin.instantiate()
	#get_parent().add_child(coin_instance)
	#coin_instance.global_position = global_position
	#no


func _on_hit_box_area_exited(area: Area2D) -> void:
	player = null
