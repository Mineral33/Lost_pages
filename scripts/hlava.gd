extends CharacterBody2D

var timer = false

var speed = 150.0
var turn_speed = 1.0
var current_dir = Vector2.RIGHT
var following = false
var opt = 1
var opt_3_timer=  0
func _physics_process(delta: float) -> void:
	following = get_parent().following
	var player = get_parent().get_parent().get_node('Player')
	if following:	
		var target_dir = (player.global_position - global_position).normalized()
		var angle_diff = current_dir.angle_to(target_dir)
	
		if angle_diff < 0.3:
			opt_3_timer += delta
		
		if opt_3_timer > 2 and timer:
			opt = 3
			opt_3_timer = 0
		elif timer:
			opt = [1,2].pick_random()
			
		if opt == 1:
			current_dir = current_dir.lerp(target_dir, turn_speed *5 * delta).normalized()
			velocity = current_dir * speed
		elif opt == 2:
			current_dir = current_dir.lerp(target_dir, turn_speed *5 * delta).normalized()
			velocity = current_dir * speed *1
		elif opt == 3:
			current_dir = current_dir.lerp(target_dir, turn_speed  * delta).normalized()
			velocity = current_dir * speed *2
		
		#print(opt)
		timer = false
		move_and_slide()
func _on_timer_timeout() -> void:
	timer = true
	
