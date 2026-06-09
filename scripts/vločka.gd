extends Area2D
@export var speed: float 
var velocity: Vector2
var  projectile_damage = 2
var ice = preload("res://assets/mec/vločka.png")
var leaf = preload("res://assets/mec/leaf.png")
var fire = preload("res://assets/mec/fire.png")
var tornado = preload("res://assets/mec/tornado.png")
var tornado_ab = preload('res://assets/mec/tornado_ab.png')
var ihlicie = preload("res://assets/mec/pierce_projectile.png")
var AoE_p = preload("res://assets/mec/projectile_AoE.png")
var tel = preload("res://assets/mec/projectile_teleport.png")


var timer
var range 
var element
var earth_heal = 10
var earth_heal_shield = 10
var hit = false
var pierce = 1
var pierced = 0
var pierced_enemies = []
var pierce_active = false
func _ready():
	await get_tree().create_timer(0.02).timeout
	$Timer.timeout.connect(queue_free)
	timer = range/speed
	$Timer.start(timer)  # Destroy after 3 seconds
	
func _process(delta):
	position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	var overlapping_objects = $".".get_overlapping_areas()
	var player = get_parent().get_child(1)
	pierce_active = get_parent().get_node('Player').pierce_ab_b
	for are in overlapping_objects:
		var parent = are.get_parent()
		#print("Hit: " + parent.name)
		#print(are.get_parent())
		#print(are.name)
		
		#if parent.is_in_group('Wall') and !pierce_active :
			#print('pierce active ',pierce_active)
			#queue_free() 
		if parent.is_in_group("Enemies") and are.name =='hurtbox' and len(pierced_enemies) < pierce and parent not in pierced_enemies:
			#print(element)
			#print(parent.get_parent())
			if parent.get_parent().name== 'červ':
					parent = parent.get_parent()
					#print('act')
			#print(parent)
			#ddprint(parent.get_parent())
			match element:
				1:
					parent.find_child("enemy_health_component", true, false).take_damage_enemy(projectile_damage,'i')
					
					player.heal_shield(5)
						
					player.update_stats()
				2:
					parent.find_child("enemy_health_component", true, false).take_damage_enemy(projectile_damage,'e')
					
					if player.health  +  earth_heal < player.max_health:
						player.health += earth_heal
					elif player.health < player.max_health and player.health + earth_heal > player.max_health:
						player.health = player.max_health
				3:
				#	print(parent)
					parent.find_child("enemy_health_component", true, false).take_damage_enemy(projectile_damage,'f')
				4:
					parent.find_child("enemy_health_component", true, false).take_damage_enemy(projectile_damage,'w')
				5,6,7:
					parent.find_child("enemy_health_component", true, false).take_damage_enemy(projectile_damage,'p')
				
			pierced_enemies.append(parent)
			if len(pierced_enemies) == pierce:
				queue_free()
			return 
		
		elif parent is Barrel and parent not in pierced_enemies:
			parent.destroy()
			pierced_enemies.append(parent)
			#print(parent,' ',pierced_enemies)
			if len(pierced_enemies) == pierce:
				queue_free()
			return 
func type(magic_weapeon):
	match magic_weapeon:
		1: $Sprite2D.texture = ice
		2:$Sprite2D.texture = leaf
		3:$Sprite2D.texture = fire
		4:
		#	print(GameManager.wind_ab_b)
			if GameManager.wind_ab_b:
				$Sprite2D.texture = tornado_ab
			else:
				$Sprite2D.texture = tornado
		5:$Sprite2D.texture = ihlicie
		6:$Sprite2D.texture = tel
		7:$Sprite2D.texture = AoE_p





func _on_wall_body_entered(body: Node2D) -> void:
	#	print(body.name, body.is_in_group('Wall'))
		pierce_active = get_parent().get_node('Player').pierce_ab_b
		
		if body.is_in_group("Wall") and !pierce_active:
			queue_free()
