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

@onready var coin
var player
var dir = Vector2.ZERO
@export var max_health = 100
@export var max_shield = 100
var momentum = 5
func _ready() -> void:
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	$AnimationPlayer.play("run")
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
	var ref = $Player_follow_raycast.get_collider()
	
	if ref == get_parent().get_child(1):
		dir = ref.global_position.x - global_position.x
		if dir > 10:
			dir = 1
			scale.x = abs(scale.x)
			$telo.flip_h = false
			$nohy.flip_h = false
			$HitBox/CollisionPolygon2D.scale.x = abs($HitBox/CollisionPolygon2D.scale.x)
			facing_right = true
			$up_autostep_raycat.scale.x = abs($up_autostep_raycat.scale.x)
			$"down_autostep raycast".scale.x = abs($"down_autostep raycast".scale.x)
		elif dir <-10:
			dir = -1
			$telo.flip_h = true
			$nohy.flip_h = true
			$HitBox/CollisionPolygon2D.scale.x = -abs($HitBox/CollisionPolygon2D.scale.x)
			facing_right = false
			$up_autostep_raycat.scale.x = -abs($up_autostep_raycat.scale.x)
			$"down_autostep raycast".scale.x = -abs($"down_autostep raycast".scale.x)
		else:
			dir= 0
	
		
		velocity.x = dir * SPEED
	
	else:
		if !$ground_detection_raycast.is_colliding():
			pass
			#print('activated')
			#flip()
			
			
			
			
	move_and_slide()
	

func get_hit():
	hit =!hit

	if hit:
		current_speed = SPEED
		#SPEED = 0
		#can_attak = false
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
		$AnimationPlayer.play("atak")
		player = area.get_parent()

func attak_reset():
	#print(player)
	if player is Player:
		$AnimationPlayer.play("atak")

		
func atack_action():
	if player is Player && !dead && can_attak: 
		player.take_damage(10,'m', ' ako vlastne?')
	
	
func die():
	dead = true
	GameManager.update_log_info('Tolper defeated + 15 gold')
	SPEED = 0
	GameManager.score += 5
	GameManager.gold += 15
	get_parent().npc_died(self)
	#print('info to level '+ str(get_parent().name))# tell game manager that this died
	$AnimationPlayer.play("die")
	#var coin_instance = coin.instantiate()
	#get_parent().add_child(coin_instance)
	#coin_instance.global_position = global_position
	#no


func _on_hit_box_area_exited(area: Area2D) -> void:
	player = null
	$AnimationPlayer.play("run")
