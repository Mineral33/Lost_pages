extends Node2D
var max_health = 1000
var max_shield = 1000
var active = 1
var door 

var center = Vector2.ZERO
var angle = 0.0
var radius = 0.0

@export var target_radius = 300.0      # distance where it settles
@export var radius_speed = 150.0        # how fast it spirals outward (px/sec)
@export var angular_speed = PI/4        # how fast it orbits (radians/sec)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door = get_parent().get_node('door_back')
	door.get_node('Area2D').get_node('CollisionShape2D').disabled = true
	door.get_node('Sign').get_node('Area2D').get_node('CollisionShape2D').disabled = true
	door.get_node('Sign').hide()
	door.get_node('Sprite2D').hide()
	
	center = get_parent().get_node('center4').global_position
	radius = target_radius
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	angle += angular_speed * delta
	position = center + Vector2(cos(angle), sin(angle)) * radius
	#rotation = angle + PI / 2.0 


func _on_heal_timer_timeout() -> void:
	$enemy_health_component.heal_hp(200)
	
func die():
	door.get_node('Area2D').get_node('CollisionShape2D').disabled = false
	door.get_node('Sign').get_node('Area2D').get_node('CollisionShape2D').disabled = false
	door.get_node('Sprite2D').show()
	door.get_node('Sign').show()
	queue_free()
