extends Sprite2D
var previous_tip_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	var angle = direction.angle()
	var dead = get_parent().dead
		# Check if Player is flipped (facing left)
	
	var player = get_parent()  # Assuming Arm is child of Player

	if player.name != "Player":
		player = player.get_node("Player")  # Fallback if Player isn't the direct parent

	if player.facing_right:
		#var min_angle = deg_to_rad(-70)
		#var max_angle = deg_to_rad(70)
		#angle = clamp(angle, min_angle, max_angle)
		$".".scale.x = abs($".".scale.x)
		$"../up_sutostep_raycast".scale.x =abs($"../up_sutostep_raycast".scale.x)
		$"../down_autostep_raycast".scale.x =abs($"../down_autostep_raycast".scale.x)
		#$weapeon.position.x = abs($weapeon.position.x)
	
	else:
		$".".scale.x = -abs($".".scale.x)
		#$weapeon.position.x = abs($weapeon.position.x)*-1
		$"../up_sutostep_raycast".scale.x = abs($"../up_sutostep_raycast".scale.x)*-1
		$"../down_autostep_raycast".scale.x = abs($"../down_autostep_raycast".scale.x)*-1
	
		
		angle = PI + angle
	
		#var min_angle = deg_to_rad(-90)
		#var max_angle = deg_to_rad(90)
		#angle = clamp(angle, min_angle, max_angle)
				#var min_angle = deg_to_rad(90)
		##print(angle)
		#var max_angle = deg#_to_rad(270)
		#angle = clamp(angle, min_angle, max_angle)
		
		
		
	if !dead:
		rotation = angle
