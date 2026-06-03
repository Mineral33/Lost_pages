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
#var max_shield= 100
#var shield
@onready var coin
var player
var dir = Vector2.ZERO
@export var max_health = 1000
@export var max_shield = 100
var active = 1
var momentum = 4
func _ready() -> void:
	#shield = max_shield
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	#health= max_health
	$AnimationPlayer.play("idle")
#	get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
	

		
func _physics_process(delta: float) -> void:
	# Add the gravity.

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !$up_autostep_raycat.is_colliding() && $"down_autostep raycast".is_colliding():
		position.y -= 20
		if facing_right:
			position.x += 2
		else:
			position.x -= 2
	var ref = $Player_follow_raycast.get_collider()
	velocity.x = 0

	if ref == get_parent().get_child(1):
		$nohy_player.play('walk')
		dir = ref.global_position.x - global_position.x
		if dir > 5:
			dir = 1
			scale.x = abs(scale.x)
			$Sprite2D.flip_h = false
			$nohy.flip_h = false
			$HitBox/CollisionPolygon2D.scale.x = abs($HitBox/CollisionPolygon2D.scale.x)
			facing_right = true
			$up_autostep_raycat.scale.x = abs($up_autostep_raycat.scale.x)
			$"down_autostep raycast".scale.x = abs($"down_autostep raycast".scale.x)
		elif dir <-5:
			dir = -1
			$Sprite2D.flip_h = true
			$nohy.flip_h = true
			$HitBox/CollisionPolygon2D.scale.x = -abs($HitBox/CollisionPolygon2D.scale.x)
			facing_right = false
			$up_autostep_raycat.scale.x = -abs($up_autostep_raycat.scale.x)
			$"down_autostep raycast".scale.x = -abs($"down_autostep raycast".scale.x)
		else:
			$nohy_player.play('idle')
			dir= 0
	
		
		velocity.x = dir * SPEED
	
	else:
		if !$ground_detection_raycast.is_colliding():
			$nohy_player.play('idle')
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


func _on_hit_box_area_entered(area: Area2D) -> void:
	pass
	
func attak_reset():
	$AnimationPlayer.play("idle")
	$nohy_player.play("idle")
	if player is Player:
		$AnimationPlayer.play("atak")
	
func atack_action():
	var bodies  =  $HitBox.get_overlapping_bodies()
	
	for body in bodies:
		
		if body == player && !dead && can_attak:
			body.take_damage(10,'m', 'ako vlastne?',5)
	
	
func die():
	dead = true
	GameManager.update_log_info('\n+ 50 gold')
	SPEED = 0
	GameManager.score += 5
	GameManager.gold += 50
	get_parent().npc_died(self)
	#print('info to level '+ str(get_parent().name))# tell game manager that this died
	$nohy.hide()
	$AnimationPlayer.play("die")
	#var coin_instance = coin.instantiate()
	#get_parent().add_child(coin_instance)
	#coin_instance.global_position = global_position
	#no


func _on_hit_box_area_exited(area: Area2D) -> void:
	pass


func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 	
		$AnimationPlayer.play("atak")
		player = area.get_parent()
	#	print(player)


func _on_attack_area_area_exited(area: Area2D) -> void:
	#$AnimationPlayer.play('run')
	player = null
	#print(area)
	
