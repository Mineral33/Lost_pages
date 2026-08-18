extends Area2D

@export var speed: float = 450
@export var damage =15
var textures = [preload("res://assets/enemies/lo_1/lo_projectiles/lo1_projectile_1.png"),preload("res://assets/enemies/lo_1/lo_projectiles/lo1_projectile_2.png"),preload("res://assets/enemies/lo_1/lo_projectiles/lo1_projectile_3.png")]
var type = 0
@export var lifetime: float = 3.0

var velocity: Vector2 = Vector2.ZERO
var angle_variation 

func _ready() -> void:
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	$LifeTimer.wait_time = lifetime
	$LifeTimer.start()
	#damage = randi_range(10,14)

func _physics_process(delta: float) -> void:
	
		position += velocity* delta
		rotation = velocity.angle()
		
func fire(direction: Vector2, spd: float = speed, type = 1) -> void:
	$Sprite2D.texture = textures[type-1]
	match type :
		1: 
			damage = randi_range(5,10)
			spd = randi_range(350,500)
		2:
			damage = randi_range(10,20)
			spd = randi_range(250,350)
		3:
			damage = randi_range(8,12)
			spd = randi_range(400,600)
			
	velocity = direction.normalized() * spd
	rotation = velocity.angle()
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			
			body.take_damage(damage,'p','frozen')
	queue_free()
func _on_life_timer_timeout() -> void:
	queue_free()
