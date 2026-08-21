extends Node2D

var markers
var stop = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	markers = $".".get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
var projectile_scene = preload("res://scenes/projectiles/lo_1/lo_p_1.tscn")
var order = [1,1,1,1,2,2,1,1,1,1,2,2,3,3,1,1,1,1,2,3,3,3,1,1,1,1,3,1,2,3,1,3,3,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,3,1,1,1,1,1,2,1,1,1,1,3 ]
var inaccuracy_degrees = 25
var projectile_type= 1
var order_position =  0
func fire_projectile():
	projectile_type = order[order_position]
	match projectile_type:
		1: 
			$"../ProjTimer".wait_time = 0.08
			projectile_type = 1
			inaccuracy_degrees = 25
		2:
			$"../ProjTimer".wait_time = 0.2
			projectile_type = 2
			inaccuracy_degrees = 15
		3:
			$"../ProjTimer".wait_time = 0.3
			projectile_type = 3
			inaccuracy_degrees = 5
	var proj = projectile_scene.instantiate()
	get_tree().current_scene.add_child(proj)
	var randi = randi_range(0,len(markers)-1)
	proj.global_position = markers[randi].global_position
	var direction = Vector2(0,1)
	var spread_radians = deg_to_rad(randf_range(-inaccuracy_degrees, inaccuracy_degrees))
	direction = direction.rotated(spread_radians)
	proj.fire(direction, 500,projectile_type) 
	order_position +=1
	if order_position == len(order):
		order_position = 0
func _on_proj_timer_timeout() -> void:
	if !stop:
		fire_projectile()
	
