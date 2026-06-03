extends CharacterBody2D
# attak on sight 
# other enemies - simple enemy projectile target
#boss stacionary 'bullet hell' 
#boss dynamic - spawning small enemies that follow and teleporting between positions
var SPEED = 120.0
var facing_right = true
var dead = false
var active = 1
var current_speed = 0
var hit = false
var can_attak = true
var momentum = 10
@onready var coin
var player
var dir = Vector2.ZERO
@export var max_health = [100,250]
@export var max_shield = 100
func _ready() -> void:
	
	$enemy_health_component.max_health =  randi_range(max_health[0],max_health[1])
	$enemy_health_component.max_shield = max_shield
	$AnimationPlayer.play("idle")
	#get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
	
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !$up_autostep_raycat.is_colliding() && $"down_autostep raycast".is_colliding():
		position.y -= 17
		if facing_right:
			position.x += 2
		else:
			position.x -= 2
	var refs = $Player_follow_area.get_overlapping_areas()
	for  ref in refs:
		if ref.get_parent() == get_parent().get_child(1):
			dir = ref.global_position.x - global_position.x
			if dir > 10:
				dir = 1
				scale.x = abs(scale.x)
				$Sprite2D.scale.x = abs($Sprite2D.scale.x)
				$HitBox.scale.x = abs($HitBox.scale.x)
				facing_right = true
				$up_autostep_raycat.scale.x = abs($up_autostep_raycat.scale.x)
				$"down_autostep raycast".scale.x = abs($"down_autostep raycast".scale.x)
				#$hurtbox.scale.x = abs($hurtbox.scale.x)
			
			elif dir <-10:
				dir = -1
				$Sprite2D.scale.x = -abs($Sprite2D.scale.x)
				$HitBox.scale.x = -abs($HitBox.scale.x)
				facing_right = false
				$up_autostep_raycat.scale.x = -abs($up_autostep_raycat.scale.x)
				$"down_autostep raycast".scale.x = -abs($"down_autostep raycast".scale.x)
				#$hurtbox.scale.x = -abs($hurtbox.scale.x)
			else:
				dir= 0
		
			
			velocity.x = dir * SPEED
		
		#else:
			#if !$ground_detection_raycast.is_colliding():
				#pass
				#print('activated')
				#flip()
				
				
				
				
	move_and_slide()
	

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 	
		player = area.get_parent()
		while player:
			$AnimationPlayer.play("attak")
			await get_tree().create_timer(1.7).timeout
			$AnimationPlayer.play("idle")

func attak_reset():
	#print(player)
	if player is Player:
		$AnimationPlayer.play("attak")

		
func atack_action():
	#print('attack action active')
	if player is Player && !dead && can_attak: 
		#print('attack action suc')
		player.take_damage(10,'m',' zamotaný do lian',5)
	
	
func die():
	dead = true
	var loot = randi_range(0,1)
	GameManager.update_log_info('untangled! +'+str(loot)+' special leaves')
	SPEED = 0
	#GameManager.score += 5
	GameManager.drop_earth[1] += loot
	#get_parent().npc_died(self)
	#print('info to level '+ str(get_parent().name))# tell game manager that this died
	$AnimationPlayer.play("die")
	queue_free()
	#var coin_instance = coin.instantiate()
	#get_parent().add_child(coin_instance)
	#coin_instance.global_position = global_position
	#no


func _on_hit_box_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:	
		player = null
		#$AnimationPlayer.play("idle")
		
func _process(delta: float) -> void:
	#print(player)
	pass
