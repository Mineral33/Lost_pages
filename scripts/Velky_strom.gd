extends CharacterBody2D
# attak on sight 
# other enemies - simple enemy projectile target
#boss stacionary 'bullet hell' 
#boss dynamic - spawning small enemies that follow and teleporting between positions
@export var projectile_scene = preload("res://scenes/projectiles/haluz_follow.tscn")
@export var projectile_speed: float =500.0
@export var fire_rate: float = 1.0
var active = 1
@onready var muzzle: Marker2D = $Marker2D
@onready var fire_timer: Timer = $FireTimer
@onready var detection_area: Area2D = $projectile_area
@export var inaccuracy_degrees: float = 25.0 
var dexamet = preload("res://scenes/enemies/Dexamet_spawn..tscn")
var SPEED = 200.0
var facing_right = true
var dead = false
var momentum = 20
var health 
var current_speed = 0
var hit = false
var can_attak = true

var shield
@onready var coin
var player
var player_r
var player_l
var rng := RandomNumberGenerator.new()
var jump_chance
var jump_timer : float
var dir = Vector2.ZERO
var spawn_timer : float = 5
var is_following
@export var max_health = 100
@export var max_shield = 1000
var lock = false
var time_to_move = 0
var dir_lock
var spike = preload("res://scenes/ingame_elements/damage_trap/wooden_spike.tscn")
func _ready() -> void:
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	
	rng.randomize()

	$AnimationPlayer.play("run")
	#get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
	
	detection_area.connect("body_entered", Callable(self, "_on_detection_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_detection_body_exited"))
	fire_timer.wait_time = fire_rate
	fire_timer.one_shot = false
	fire_timer.autostart = false
	#fire_timer.connect("timeout", Callable(self, "_shoot"))
	
func _process(delta: float) -> void:

#	#print(SPEED)
	pass	
		
func _physics_process(delta: float) -> void:
	# Add the gravity.



	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var ref = $player_follow_area.get_overlapping_areas()
	for i in ref:
		if is_instance_valid(i):
			if i.get_parent() is Player && i.get_parent() == get_parent().get_child(1):
				is_following = true
				dir = i.global_position.x - global_position.x
				if dir > 25 and !lock:
					dir = 1
					$telo.scale.x =  abs($telo.scale.x)
					$nohy.scale.x =  abs($nohy.scale.x)
					facing_right = true
					velocity.x = dir * SPEED
				elif dir <-25 and !lock:
					dir = -1
					$telo.scale.x = - abs($telo.scale.x)
					$nohy.scale.x = - abs($nohy.scale.x)
					facing_right = false
					velocity.x = dir * SPEED
				else:
					if !lock:
						dir_lock = [ -1, 1 ,0,0].pick_random()
					lock = true
					time_to_move += delta
					if time_to_move > 1:
						lock = false
						time_to_move = 0
					velocity.x = dir_lock * SPEED
		else:
			is_following = false		
	move_and_slide()
	
func die():
	dead = true
	GameManager.update_log_info('Prazosin, mighty tree was defeated + 1500 money')
	SPEED = 0
	GameManager.gold += 1500
	get_parent().npc_died(self)
	##print('info to level '+ str(get_parent().name))# tell game manager that this died
	await get_tree().create_timer(1).timeout
	queue_free()
	#var coin_instance = coin.instantiate()
	#get_parent().add_child(coin_instance)
	#coin_instance.global_position = global_position
	#no



	
func _shoot() -> void:
	if player == null:
		return
	if not is_instance_valid(player):
		player = null
		return

	var proj = projectile_scene.instantiate()
	get_tree().current_scene.add_child(proj)
	proj.damage = randf_range(20,30)
	proj.global_position = muzzle.global_position
	var direction = (player.global_position - muzzle.global_position).normalized()
	var spread_radians = deg_to_rad(randf_range(-inaccuracy_degrees, inaccuracy_degrees))
	direction = direction.rotated(spread_radians)
	proj.fire(direction, projectile_speed)
	
	
func _on_detection_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player = body
		
		#fire_timer.start()  # start shooting when player is detected

func _on_detection_body_exited(body: Node) -> void:
	if body == player:
		player = null
	
		#fire_timer.stop()  # stop shooting when player leaves area


func _on_prava_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 	
		player_r = area.get_parent()
		while player_r != null:
			$prava/ap_p.play("prava")
			await get_tree().create_timer(3).timeout


func _on_prava_hit_box_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		player_r = null

# nedava dmg
func _on_lava_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 	
		player_l = area.get_parent()
		while player_l != null:
			$Node2D/lava/ap_l.play("lava")
			await get_tree().create_timer(3).timeout


func _on_lava_hit_box_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		
		player_l = null
	
	
func atack_action_r():
	if player_r is Player && !dead && can_attak: 
		player.take_damage(randf_range(50,70),'m', 'strom')
		
func atack_action_l():
	if player_l  is Player && !dead && can_attak: 
		player.take_damage(randf_range(50,70),'m', 'strom')
		
	


func _on_jump_timer_timeout() -> void:
	SPEED = randf_range(300,350)
	if $enemy_health_component.health/float(max_health) <= 0.7:
		SPEED = randf_range(325,375)
	if $enemy_health_component.health/float(max_health) <= 0.3:
		SPEED = randf_range(350,400)
	
	
	$JumpDurationTimer.start(2)
	$JumpTimer.start(randf_range(7,8))

func _on_jump_duration_timer_timeout() -> void:
	SPEED = 175
	if $enemy_health_component.health/float(max_health) <= 0.7:
		SPEED = 200
	if $enemy_health_component.health/float(max_health) <= 0.3:
		SPEED = 225

	


func _on_spike_timer_timeout() -> void:
	var spike_inst = spike.instantiate()
	spike_inst.global_position = $floor_marker.global_position #floor
	##print('spike created at ',spike_inst.global_position)
	get_parent().add_child(spike_inst)
	
