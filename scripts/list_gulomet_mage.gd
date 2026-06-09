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
@export var standing = true
@onready var coin
var player
var dir = 1
@export var max_health = 100
@export var max_shield = 100
var momentum = 5
var distance_traveled = 0
var distance_turn = 250
func _ready() -> void:
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	$AnimationPlayer.play("idle")
	$nohy_player.play('walk')
	await get_tree().create_timer(randf_range(0,0.7)).timeout
	$Timer.start(randf_range(0.5,0.7))
func _physics_process(delta: float) -> void:
	if not is_on_floor():
			velocity += get_gravity() * delta
	# Add the gravity.
	if not standing:
		
		if !$up_autostep_raycat.is_colliding() && $"down_autostep raycast".is_colliding():
			position.y -= 17
			if facing_right:
				position.x += 2
			else:
				position.x -= 2
		distance_traveled += velocity.x *delta
		if distance_traveled > distance_turn:
			$Sprite2D.flip_h = false
			$nohy.flip_h = false
			facing_right = false
			$up_autostep_raycat.scale.x = -abs($up_autostep_raycat.scale.x)
			$"down_autostep raycast".scale.x = -abs($"down_autostep raycast".scale.x)
			dir = -1
		elif distance_traveled < -distance_turn:
			$Sprite2D.flip_h = true
			$nohy.flip_h = true
			facing_right = true
			$up_autostep_raycat.scale.x = abs($up_autostep_raycat.scale.x)
			$"down_autostep raycast".scale.x = abs($"down_autostep raycast".scale.x)
			dir = 1
		velocity.x = dir * SPEED
	else: $nohy_player.play('idle')
	move_and_slide()
	

	
func die():
	dead = true
	GameManager.update_log_info('mage defeated + 15 gold')
	SPEED = 0
	GameManager.gold += 15
	queue_free()

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 	
		player = area.get_parent()

func _on_attack_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 
		player = null
		$nohy_player.play("run")


var bomb = preload("res://scenes/projectiles/list_projectile.tscn")
func _on_timer_timeout() -> void:
	if player:
		var direction =(player.global_position - $Marker2D.global_position).normalized()
		var bomb_inst = bomb.instantiate()
		bomb_inst.position = $Marker2D.global_position
		var inaccuracy = 0.25
		var spread = Vector2(
		randf_range(-inaccuracy, inaccuracy),
		randf_range(-inaccuracy, inaccuracy)
	)
		bomb_inst.fire((direction + spread).normalized(), randf_range(280,350))
		get_parent().add_child(bomb_inst)
	$Timer.start(randf_range(0.5,0.7))	
