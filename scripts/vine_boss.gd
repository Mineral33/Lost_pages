extends CharacterBody2D


const SPEED = 300.0
var bonus_Speed = 0
const JUMP_VELOCITY = -400.0
var max_health = 300
var max_shield = 1000
var player 
var vines = []
var active = 1
func _ready() -> void:
	#await  get_tree().create_timer(0.1).timeout
	player = get_parent().get_node('Player')
	for i in range(3):
		var vine = get_parent().get_node('vine'+str(i+1))
		vine.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		

		vines.append(vine)
func _physics_process(delta: float) -> void:
	for vine in vines:
		vine.points[0] =  vine.to_local(global_position)
	#print(attack_ref)


	var dist = global_position.distance_to(player.global_position)
	if dist > 10.0:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * (125 +bonus_Speed)
		if $enemy_health_component.shield/max_shield < 0.5:
			velocity = dir * (150 +bonus_Speed)
			if $enemy_health_component.shield/max_shield < 0.3:
				velocity = dir *(175	+bonus_Speed)
	
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

var attack_ref
func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player  and !player.dead:
		attack_ref = area.get_parent()
		while attack_ref and !player.dead:
			area.get_parent().take_damage(25,'m','zviazaný')
			await get_tree().create_timer(1).timeout	


func _on_instakill_mouth_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !player.dead:
		area.get_parent().take_damage(1000,'m','eaten',INF,'bypass')
		get_parent().get_node('UImanager').jumpscare(1)

func _on_attack_area_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		attack_ref = null
		
		
	
var drag = false
var active_vines = 0
var vine_texture = preload("res://assets/enemies/vine_boss/vine_stand.png")
var vines_attachment =[]
var va_offsets = []
var rng = RandomNumberGenerator.new()
#var Timers = [$VineTimer1,$VineTimer2,$VineTimer3,$VineTimer4]
func projectile_hit():
	active_vines += 1
	if active_vines <= 7:
		var vine_attachment = Line2D.new()
		vine_attachment.texture = vine_texture
		vine_attachment.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		vine_attachment.texture_mode = Line2D.LINE_TEXTURE_TILE
		vine_attachment.width = 16
		
		add_child(vine_attachment)  # add first before setting anything
		
		var marker = get_node("Marker" + str(active_vines))
		print(active_vines)
		vine_attachment.add_point(to_local(marker.global_position))
		var offset =Vector2(randf_range(-10, 10), randf_range(-40, 40))
		va_offsets.append(offset)
		vine_attachment.add_point(to_local(player.global_position) + offset)
		vines_attachment.append(vine_attachment)
		drag = true
		
		$Attachment_vine_cleansing_timer.start($Attachment_vine_cleansing_timer.time_left + 8)
		 

func _process(delta: float) -> void:
	#print(vines_attachment)
	
	for i in range(len(vines_attachment)):
		if vines_attachment[i]:
			vines_attachment[i].points[1] = to_local(player.global_position) +va_offsets[i]
		
	if drag and !player.dead:
		var dir = (player.global_position - $proj_marker.global_position).normalized()
		
		player.global_position -= dir * active_vines/2
		print($Attachment_vine_cleansing_timer.time_left)
		
var proj =preload('res://scenes/projectiles/vine_projectile.tscn')
func _on_projectile_timer_timeout() -> void:
	if !player.dead:	
		var dir = (player.global_position - $proj_marker.global_position).normalized()
		var projectile = proj.instantiate()
		#projectile.position = $proj_marker.global_position + Vector2(-100,0)
		projectile.position = get_parent().to_local($proj_marker.global_position)
		var inaccuracy = 0.1
		var spread = Vector2(
			randf_range(-inaccuracy, inaccuracy),
			randf_range(-inaccuracy, inaccuracy)
		)
		
		projectile.dir = dir + spread
		projectile.parent = self
		projectile.is_projectile = true
		get_parent().add_child(projectile)
	#	print(projectile.global_position)
	$ProjectileTimer.start(abs(rng.randfn(2.5,1.5)))


func _on_speed_up_timer_timeout() -> void:
	$SpeedUpTimer.start(abs(rng.randfn(10,1.5)))
	bonus_Speed = rng.randfn(80,30)
	await  get_tree().create_timer(3).timeout
	bonus_Speed = 0
func die():

	GameManager.update_log_info('Tolper defeated + 1200 gold')
	GameManager.gold += 1200
	queue_free()


func _on_attachment_vine_cleansing_timer_timeout() -> void:
	active_vines = 0
	for i in range(len(vines_attachment)):		
		vines_attachment[i].queue_free()
	vines_attachment = []
	va_offsets = []
