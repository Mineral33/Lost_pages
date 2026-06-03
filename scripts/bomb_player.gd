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
	#print(body)
	if body.is_in_group('Wall'):
		$explosion.show()
		explode = true
		$LifeTimer.stop()
		$LifeTimer.start(2)
func _on_area_entered(area: Area2D) -> void:
	
	if area.get_parent().is_in_group("Enemies") and area.name == 'hurtbox':
		$explosion.show()
		explode = true
		$LifeTimer.stop()
		$LifeTimer.start(2)





func _on_timer_timeout() -> void:
	#print(in_explosion,' ',explode)
	
	var areas =  $Area2D.get_overlapping_areas()
	for area in areas:
		if  area.get_parent().is_in_group("Enemies") and area.name == 'hurtbox':
			area.get_parent().find_child("enemy_health_component", true, false).take_damage_enemy(damage, 'p')
