extends Area2D
var center = Vector2.ZERO
var angle = 0.0
var radius = 0.0

@export var target_radius = 300.0      # distance where it settles
@export var radius_speed = 150.0        # how fast it spirals outward (px/sec)
@export var angular_speed = PI/4        # how fast it orbits (radians/sec)
@export var center_idx = 1
func _ready() -> void:
	match center_idx:
		1:center = get_parent().get_node('center').global_position
		2:center = get_parent().get_node('center2').global_position
		3:center = get_parent().get_node('center3').global_position
	radius = target_radius
func _process(delta: float) -> void:	
	angle += angular_speed * delta

	
	position = center + Vector2(cos(angle), sin(angle)) * radius
	rotation = angle + PI / 2.0  # faces tangent to the orbit; use "- PI/2" to flip direction
		
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			
			body.take_damage(20,'p','frozen')
