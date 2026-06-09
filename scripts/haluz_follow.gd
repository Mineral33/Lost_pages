extends Area2D

var direction : Vector2 = Vector2(10,10)
@export var speed: float = 400.0
@export var damage: int = 25
var rng = RandomNumberGenerator.new()

@export var lifetime: float = 3.0
var follow_time = 0
var velocity: Vector2 = Vector2.ZERO
var angle_variation 
var random_angle 
var active = false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	$LifeTimer.wait_time = lifetime
	$LifeTimer.start()
	$FollowTimer.wait_time = follow_time
	$FollowTimer.start()
	randomize()
	direction = Vector2.UP.rotated(deg_to_rad(rng.randf_range(-70, 70)))
	damage = randf_range(15,20)
	
func _physics_process(delta: float) -> void:

	position += direction *speed * delta

func fire(direction: Vector2, spd: float = speed) -> void:
	velocity = direction.normalized() * spd
	rotation = velocity.angle()
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and active:
		if body.has_method("take_damage"):
			body.take_damage(damage,'p','haluz')
			queue_free()
	
	
func _on_life_timer_timeout() -> void:
	queue_free()
	
	
func _on_follow_timer_timeout() -> void:
	direction = (get_parent().get_child(1).global_position - global_position).normalized()
	active = true
