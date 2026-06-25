extends Area2D
var direction = Vector2.DOWN  
var texture =preload("res://assets/enemies/motyl/blesk_motyl/blesk_motyl0000.png")

func _ready() -> void:
	#await  get_tree().create_timer(0.05).timeout
	$Sprite2D.texture = texture
	rotation = direction.angle() - PI / 2
	$Timer.start()

	
	
func _on_area_entered(area: Area2D) -> void:
	#print(area)
	if area.get_parent() is Player:
		var damage = [10,12,15].pick_random()
		area.get_parent().take_damage(damage,'p',' bzzzzz')
		
func ground():
	var space = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position +direction*50 # check 60px below
	)
	query.exclude = [self]
	var result = space.intersect_ray(query)
	return result.size() > 0 
	
	
	
	#$RayCast2D.force_raycast_update()
	#var areas = get_overlapping_areas()
	###print(areas)
	#return $RayCast2D.is_colliding()
	
	#var areas = get_overlapping_bodies()
	#for area in areas:
	#	#print(area)
#		if area.get_parent().is_in_group('Wall'):
	#		return true
	#	if area is TileMap or area is TileMapLayer:
	#		return true
	#return false


func _on_timer_timeout() -> void:
	queue_free()
