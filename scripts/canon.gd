extends StaticBody2D

var Snow_Ball = load("res://scenes/projectiles/snowball.tscn")
var Debris = load('res://scenes/old/cannon_debris.tscn')

@export var shooting : bool
var firerate = 2
var active= 1
@onready var animation= $AnimationPlayer
@onready var firepoint = $FirePoint
var max_health = 250
var max_shield = 0
var health
var momentum = 10
func _ready():
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	health = max_health
	shooting = true
	shoot()
	
func shoot():
	while shooting:
		$AnimationPlayer.play("fire")
		await get_tree().create_timer(firerate).timeout

func fire():
	var spawned_ball = Snow_Ball.instantiate()
	#spawned_ball.direction = Vector2(1,0)
	spawned_ball.global_position = firepoint.position
	add_child(spawned_ball)
	spawned_ball.fire(Vector2(1,0), 200)
		
func die():
	var spawned_debris = Debris.instantiate()
	spawned_debris.global_position = position
	spawned_debris.get_child(1).play("Crumble")
	get_tree().get_root().get_child(1).add_child(spawned_debris)
	var loot = randi_range(80,120)
	GameManager.update_log_info('Canon was defeated +'+str(loot)+' money, antimonite ore 10 ')
	GameManager.gold += loot
	GameManager.sutre['antimonite'] += 10
	queue_free()
	
	
