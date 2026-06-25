extends Area2D


@export var speed: float = 350
@export var top_damage: int = 100


@export var lifetime: float = 1.2

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
	var t = $LifeTimer.time_left / 1.2  # 0.0 to 1.0
	var damage = lerp(top_damage,int(20.0), t)
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			
			body.take_damage(damage,'p','odfúknutý')
	queue_free()
func _on_life_timer_timeout() -> void:
	queue_free()
#func _process(delta: float) -> void:
	##print(self, ' ',$LifeTimer.time_left)
	
