extends Sprite2D

@export var travel_distance = 1200
var distamce_already_traveled = 0
var dir = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("run")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if distamce_already_traveled >= travel_distance:
		scale.x = -(scale.x)
		dir = -dir
		distamce_already_traveled = 0
	position.x += 2 * dir
	distamce_already_traveled += 2
