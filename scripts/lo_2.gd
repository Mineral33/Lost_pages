extends Node2D
var max_health = 1000
var max_shield = 500
var active = 1

var projectile_1 = preload("res://scenes/projectiles/lo_1/lo2_p_1.tscn")

var spike = preload("res://scenes/ingame_elements/damage_trap/ice_spike.tscn")
var spike_markers = []

var wall = preload("res://scenes/ingame_elements/ice_wall_lo.tscn")

var projectile_2 = preload("res://scenes/projectiles/lo_1/lo2_p_2.tscn")

var projectile_3 = preload('res://scenes/projectiles/lo_1/lo2_p_3.tscn')
var inaccuracy_degrees = 12
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spike_markers = $spike_markers.get_children()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



'''
	
	'''


func _on_proj_timer_timeout() -> void:
	$AnimationPlayer.play("attack")
func show_particles():
	$Sprite2D2.show()
	$Sprite2D3.show()
	await get_tree().create_timer(1).timeout
	$Sprite2D2.hide()
	$Sprite2D3.hide()
func fire():
	var rng = randi_range(0,4)
	match rng:
		0:
			inaccuracy_degrees = 12
			var proj = projectile_1.instantiate()
			get_tree().current_scene.add_child(proj)
			proj.global_position = $Marker2D.global_position
			var direction = (get_parent().get_node('Player').global_position - $Marker2D.global_position).normalized()
			var spread_radians = deg_to_rad(randf_range(-inaccuracy_degrees, inaccuracy_degrees))
			direction = direction.rotated(spread_radians)
			proj.fire(direction, 450) 
		1:
			var spike_type = [[0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],[1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,1],[1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1]].pick_random()
			for i in range(16):
				if spike_type[i]:
					var spike_inst = spike.instantiate()
					spike_inst.global_position = spike_markers[i].global_position 
					
					get_parent().add_child(spike_inst)
		2:
			for i in range(5):
				var  wall_inst = wall.instantiate()
				var direction = (get_parent().get_node('Player').global_position - $Marker2D.global_position).normalized()
				wall_inst.global_position = $Marker2D.global_position + direction*200*i #
				
				wall_inst.rotation = direction.angle()
				get_parent().add_child(wall_inst)
		3:
			inaccuracy_degrees = 20
			var proj = projectile_2.instantiate()
			get_tree().current_scene.add_child(proj)
			proj.global_position = $Marker2D.global_position
			var direction = (get_parent().get_node('Player').global_position - $Marker2D.global_position).normalized()
			var spread_radians = deg_to_rad(randf_range(-inaccuracy_degrees, inaccuracy_degrees))
			direction = direction.rotated(spread_radians)
			proj.fire(direction, 700) 
		4:
			var proj = projectile_3.instantiate()
			get_tree().current_scene.add_child(proj)
			proj.global_position = $Marker2D.global_position
		
	$AnimationPlayer.play("back")
func die():
	get_parent().get_child(0).lo_cutscene_3()
