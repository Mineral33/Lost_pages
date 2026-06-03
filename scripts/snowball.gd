extends Area2D



@export var speed: float = 400.0
@export var damage: int = 50



@export var lifetime: float = 3.0

var velocity: Vector2 = Vector2.ZERO
var angle_variation 

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	$LifeTimer.wait_time = lifetime
	$LifeTimer.start()


func _physics_process(delta: float) -> void:
	
		position += velocity* delta
		rotation = velocity.angle()
		
func fire(direction: Vector2, spd: float = speed) -> void:
	velocity = direction.normalized() * spd
	rotation = velocity.angle()
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(damage,'p', 'kameň')
			queue_free()
func _on_life_timer_timeout() -> void:

	queue_free()
