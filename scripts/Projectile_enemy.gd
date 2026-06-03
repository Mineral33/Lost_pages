extends Node2D

@export var projectile_scene = preload("res://scenes/projectiles/haluz_follow.tscn")
@export var projectile_speed: float =500.0
@export var fire_rate: float = 1.0
@export var max_health = 200
@export var max_shield = 100
var active = 1
var momentum = 12
@onready var muzzle: Marker2D = $Marker2D
@onready var fire_timer: Timer = $FireTimer
@onready var detection_area: Area2D = $Area2D
@export var inaccuracy_degrees: float = 25.0 
var player: Node2D = null
#var shield 
#@export var max_shield = 20
var dead = false
#@export var max_health = 25
#var health 
var hit = false
@export var attack_range = 1200
func _ready() -> void:
	$enemy_health_component.max_health = max_health
	$enemy_health_component.max_shield = max_shield
	$Area2D/CollisionShape2D.shape.radius = attack_range
	#health= max_health
	#shield = max_shield
	detection_area.connect("body_entered", Callable(self, "_on_detection_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_detection_body_exited"))
	fire_timer.wait_time = fire_rate
	fire_timer.one_shot = false
	fire_timer.autostart = false
	fire_timer.connect("timeout", Callable(self, "_shoot"))

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

	var proj = projectile_scene.instantiate()
	get_tree().current_scene.add_child(proj)

	proj.global_position = muzzle.global_position
	var direction = (player.global_position - muzzle.global_position).normalized()
	var spread_radians = deg_to_rad(randf_range(-inaccuracy_degrees, inaccuracy_degrees))
	direction = direction.rotated(spread_radians)
	proj.fire(direction, projectile_speed)

var haluz = preload("res://scripts/haluz.gd")

func shoot():
	var haluz_inst = haluz.instantiate()
	var direction = (player.global_position - global_position).normalized()
	haluz_inst.position = $Marker2D.global_position
	var inaccuracy = 0.05
	var spread = Vector2(
	randf_range(-inaccuracy, inaccuracy),
	randf_range(-inaccuracy, inaccuracy))
	haluz_inst.fire((direction + spread).normalized(), 750)
	
	get_parent().add_child(haluz_inst)

func die():
	var loot = randi_range( 3,5)
	GameManager.update_log_info('Tree was defeated! +'+str(loot)+' special leaves')
	#get_parent().npc_died(self)
	GameManager.drop_earth[1] += loot
	queue_free()
