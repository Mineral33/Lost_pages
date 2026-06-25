extends Sprite2D
var max_health = 5
var max_shield = 0
var distance_traveled = 0
var active = 1
var limit = 0
var c
var x = 2
var x_init
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fly")
	limit = randi_range(200,300)
	c = randf_range(0,PI)
	distance_traveled = [-251,251].pick_random()
	
	x_init = [1.8,2.2].pick_random()

func _process(delta):
	c += delta * 2
	distance_traveled += x
	var y = sin(c)
	##print(distance_traveled)
	if distance_traveled > limit:
		x = -abs(x_init)
	elif distance_traveled < -limit:
		x = abs(x_init)
	position += Vector2(x , y+ randf_range(-2,2))
func die():
	queue_free()
func take_damage(amount,type,cause):
	$enemy_health_component.take_damage_enemy(amount,type)
