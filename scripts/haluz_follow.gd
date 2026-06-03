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
var start_dir
var first_time = true
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	$LifeTimer.wait_time = lifetime
	$LifeTimer.start()
	$FollowTimer.wait_time = follow_time
	$FollowTimer.start()
	randomize()
func _physics_process(delta: float) -> void:
	follow_time += delta
	if follow_time < 0.5:
		if first_time:
			start_dir = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
			first_time = false
		position += start_dir *speed * delta
	if 0.5 < follow_time and follow_time < 0.8:
		direction = (get_parent().get_child(1).global_position - global_position).normalized()
		position += direction *speed * delta
	elif follow_time > 0.8:
		position += direction *speed * delta
	
		
func fire(direction: Vector2, spd: float = speed) -> void:
	velocity = direction.normalized() * spd
	rotation = velocity.angle()
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(damage,'p','haluz')
	queue_free()
func _on_life_timer_timeout() -> void:
	queue_free()
