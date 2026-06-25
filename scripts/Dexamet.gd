extends CharacterBody2D
# attak on sight 
# other enemies - simple enemy projectile target
#boss stacionary 'bullet hell' 
#boss dynamic - spawning small enemies that follow and teleporting between positions
var SPEED = 100
var facing_right = true
var dead = false
@export var max_health = 50
@export var max_shield = 50
var active = 1
var current_speed = 0
var hit = false
var can_attak = true
#var max_shield= $enemy_health_component.shield
#var shield
#var max_health = $enemy_health_component.max_health
#var health 
@onready var coin
var player
var dir = 500
var ref
var rng := RandomNumberGenerator.new()
var jump_chance
var jump_timer : float
var slow=1
var stop = 0
var jump_velocity = 500
var momentum = 7
@export var damage = 7
func _ready() -> void:
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	$AnimationPlayer.play("run")
	#get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
	

		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	jump_timer += delta
	
	if jump_timer > 2:
		var action = [0,1].pick_random()
		if action == 1:
			velocity.y -= jump_velocity
		jump_timer = 0
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !$up_autostep_raycat.is_colliding() && $"down_autostep raycast".is_colliding():
		position.y -= 17
		if facing_right:
			position.x += 2
		else:
			position.x -= 2
	var ref = $player_follow_area.get_overlapping_areas()
	
	
	for i in ref:
			
		if i.get_parent() == get_parent().get_child(1):
			dir = i.global_position.x - global_position.x
			
			stop = 0
			if abs(dir) > 350:
				if facing_right:
			
					velocity.x = 50
				elif !facing_right:
					velocity.x = -50
				
				##print('mid slow')
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
				if SPEED <= 50:
					SPEED = 0
			
			if SPEED > 200:
				SPEED = 200
				
				
				
			if slow == 1:
				##print(SPEED)
				velocity.x += dir * SPEED/40
				##print('not slowed') 
			if slow != 1:
				if facing_right:
					velocity.x = slow 
				elif !facing_right:
					velocity.x = -slow 
				##print('slowed')
		
		else:
			if !$ground_detection_raycast.is_colliding():
				pass
				##print('activated')

			
	if stop:
		velocity.x = 0
			
	move_and_slide()
	



func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 	
		player = area.get_parent()
		while player != null:
			player.take_damage(damage,'m',' poleno', 5)
			await get_tree().create_timer(0.5).timeout
#func atack_action():
#	if player is Player && !dead && can_attak: 
#		player.take_damage(10,'m', 5)
#	$AnimationPlayer.play("run")
	
func die():
	dead = true
	var loot = randi_range(2,3)
	GameManager.update_log_info('You made wood chips of dexamet + '+str(loot)+' dense wood')
	SPEED = 0
	GameManager.drop_earth[0] += loot
	
	#get_parent().npc_died(self)
	##print('info to level '+ str(get_parent().name))# tell game manager that this died
	queue_free()
	#var coin_instance = coin.instantiate()
	#get_parent().add_child(coin_instance)
	#coin_instance.global_position = global_position
	#no


func _on_hit_box_area_exited(area: Area2D) -> void:
	player = null


func _on_player_follow_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		stop = 1
		##print("stop")
