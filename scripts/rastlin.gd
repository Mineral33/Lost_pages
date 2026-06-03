extends CharacterBody2D

# stupid roamer
var SPEED = 60.0
var facing_right = true
var dead = false
var max_health = 10
var health 
var current_speed = 0
var hit = false
var can_attak = true
@onready var coin

func _ready() -> void:
	health= max_health
	$AnimationPlayer.play("run")
	coin = preload("res://scenes/coin.tscn")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()


	velocity.x = SPEED
	move_and_slide()
	
func take_damage(damage_amount):
	if !dead:
		$AnimationPlayer.play("hit")
		health -= damage_amount
		get_node("Healthbar").update_healthbar(health,max_health)
		if health <= 0:
			die()  
func get_hit():
	hit =!hit
"""
	if hit:
		current_speed = SPEED
		SPEED = 0
		can_attak = false
	else:
		SPEED = current_speed
		can_attak = true
		$AnimationPlayer.play("run")
"""
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x)*-1
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED)*-1


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead && can_attak: 
		area.get_parent().take_damage(1)
		
func die():
	SPEED = 0
	GameManager.score += 5
	$AnimationPlayer.play("die")
	var coin_instance = coin.instantiate()
	get_parent().add_child(coin_instance)
	coin_instance.global_position = global_position
