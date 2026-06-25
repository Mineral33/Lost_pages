extends Area2D


@export var speed: float = 400.0
@export var damage: int = 25


@export var lifetime: float = 3.0
var in_explosion = false
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	$LifeTimer.wait_time = lifetime
	$LifeTimer.start()
	damage = randi_range(22,28)
var explode = false

func _physics_process(delta: float) -> void:
	if not explode:
		position += velocity* delta
		rotation = velocity.angle()
		
func fire(direction: Vector2, spd: float = speed) -> void:
	velocity = direction.normalized() * spd
	rotation = velocity.angle()
	
func _on_life_timer_timeout() -> void:
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	##print(body)
	if body.is_in_group('Wall') or body.is_in_group('Player'):
		$explosion.show()
		explode = true
		$LifeTimer.stop()
		$LifeTimer.start(2)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		in_explosion = true
		
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('Player'):
		in_explosion = false



func _on_timer_timeout() -> void:
	##print(in_explosion,' ',explode)
	if  in_explosion and explode:
			get_parent().get_node('Player').take_damage(damage,'p','boom')
	
