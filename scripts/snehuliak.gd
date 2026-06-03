extends Node2D

@export var projectile_scene = preload("res://scenes/projectiles/snowball.tscn")
@export var projectile_speed: float =500.0
@export var fire_rate: float = 1.0
@export var flip_h = false
@onready var muzzle: Marker2D = $Marker2D
@onready var fire_timer: Timer = $FireTimer
@onready var detection_area: Area2D = $Area2D
@export var inaccuracy_degrees: float = 25.0 
var player: Node2D = null
var active = 1
var dead = false
@export var max_health = 30
@export var max_shield = 100
@export var is_objective = false

var hit = false
@export var projectile_damage = 10
func _ready() -> void:
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	detection_area.connect("body_entered", Callable(self, "_on_detection_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_detection_body_exited"))
	fire_timer.wait_time = fire_rate
	fire_timer.one_shot = false
	fire_timer.autostart = false
	fire_timer.connect("timeout", Callable(self, "_shoot"))
	$Sprite2D.flip_h = flip_h
	#get_node("Healthbar").update_healthbar(health,max_health,shield,max_shield,true)
func _on_detection_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player = body
		fire_timer.start()  # start shooting when player is detected

func _on_detection_body_exited(body: Node) -> void:
	if body == player:
		player = null
		fire_timer.stop()  # stop shooting when player leaves area

func _shoot() -> void:
	if player == null:
		return
	if not is_instance_valid(player):
		player = null
		return
#wtf
	var proj = projectile_scene.instantiate()
	get_tree().current_scene.add_child(proj)
	proj.damage = projectile_damage
	proj.global_position = muzzle.global_position
	var direction = (player.global_position - muzzle.global_position).normalized()
	var spread_radians = deg_to_rad(randf_range(-inaccuracy_degrees, inaccuracy_degrees))
	direction = direction.rotated(spread_radians)
	proj.fire(direction, projectile_speed)



func die():
	GameManager.update_log_info('\n+ 25 gold\n+ 2 livingwood')
	get_parent().npc_died(self)
	GameManager.score += 5
	GameManager.livingwood += 1
	queue_free()
