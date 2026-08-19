extends Area2D

@export var speed: float = 700
@export var damage = 35

@export var lifetime: float = 4

var velocity: Vector2 = Vector2.ZERO
var angle_variation 
var chase = false
var type = 0
var textures = [preload("res://assets/enemies/lo_1/lo_projectiles/lo2_homing_hp.png"), preload("res://assets/enemies/lo_1/lo_projectiles/lo2_homing_shd.png")]
func _ready() -> void:
	type = randi_range(0,1)
	$Sprite2D.texture = textures[type]
	connect("body_entered", Callable(self, "_on_body_entered"))
	$LifeTimer.wait_time = lifetime
	$LifeTimer.start()


func _physics_process(delta: float) -> void:
	if !chase:
		position += velocity* delta
		rotation = velocity.angle()
	else:
		var dir = (get_parent().get_node('Player').global_position - global_position).normalized()
		velocity = dir * speed
		position += velocity* delta
		rotation = velocity.angle()
func fire(direction: Vector2, spd: float = speed, type = 1) -> void:
	speed = 700
	velocity = direction.normalized() * 600
	rotation = velocity.angle()
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			
			body.take_damage(damage,'p','frozen')
			if type == 0:
				get_parent().get_node('lo_2').get_node('enemy_health_component').heal_hp(50)
			else:
				get_parent().get_node('lo_2').get_node('enemy_health_component').heal_shd(125)
	queue_free()
func _on_life_timer_timeout() -> void:
	queue_free()


func _on_no_chase_timer_timeout() -> void:
	chase = true
	speed = 300
	
