extends Node2D
var health
var max_health 
var shield
var max_shield 
var parent = self.get_parent()
var momentum 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.3).timeout
	health = get_parent().max_health
	max_health = get_parent().max_health
	shield = get_parent().max_shield
	max_shield = get_parent().max_shield
	momentum = get_parent().get("momentum")
	#if momentum != null:
		#print(momentum)
	print(get_parent().name, get_parent().max_shield)
	
	if max_shield > 0:
		get_parent().get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
	else: 
		get_parent().get_node("Healthbar").update_healthbar(health,max_health)
	


func take_damage_enemy(damage_amount,type, player_momentum := INF):
	#print(self.get_parent().active)
	
	if !self.get_parent().get('active'):
		self.get_parent().get_up()
		
	#$AnimationPlayer.play("hit")
	
	if type == 'm':
		#if momentum < player_momentum: 
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
		if !GameManager.wind_ab_b:
			if shield > 0:
				shield -= damage_amount*0.7
				health -= damage_amount*0.5
			elif shield - damage_amount < 0 and shield >0:
				damage_amount -= shield
				shield = 0
				health -= damage_amount
			elif shield <= 0:
				health -= damage_amount
		else:
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
	elif type == 'mf':
		if shield > 0:
			shield -= damage_amount*3
		elif shield - damage_amount < 0 and shield >0:
			damage_amount -= shield
			shield = 0
			health -= damage_amount*1.5
		elif shield <= 0:
			health -= damage_amount
		
	#print(health,' ',max_health)
	if max_shield > 0:
		get_parent().get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
	else:
		get_parent().get_node("Healthbar").update_healthbar(health,max_health)
	if health <= 0:
			get_parent().die()
	get_parent().get_node('damage_number_display').display_took_damage(damage_amount)
	is_figting = true
	$Timer.start()
	
	
var is_figting = true

func _on_timer_timeout() -> void:
	is_figting = false

func _on_timer_2_timeout() -> void:
	if !is_figting:
		heal()

func heal():
	health += round(max_health/20)
	shield += round(max_shield/20)
	if health >= max_health:
		health = max_health
	else:
		get_parent().get_node('damage_number_display').display_took_heal(max_health/20)
	if max_shield > 0:
		if shield >= max_shield:
			shield = max_shield
		else:
			get_parent().get_node('damage_number_display').display_took_heal_shield(max_shield/20)
			
	if max_shield > 0:
		get_parent().get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
	else:
		get_parent().get_node("Healthbar").update_healthbar(health,max_health)
	
	
	
