



extends Node2D

@export var point_a: Vector2   # where the spike moves toward
var point_b: Vector2           # starting point (auto-set)
@export var speed: float = 200.0
var going_to_b := false        # start by moving from B → A

func _ready():
	point_b = position   # store the spike's starting position
	going_to_b = false   # spike begins by going from B to A
	point_a = $Marker2D.global_position
func _process(delta):
	var target = point_a if !going_to_b else point_b

	position = position.move_toward(target, speed * delta)

	if position.distance_to(target) < 1.0:
		going_to_b = !going_to_b



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().take_damage(20,"m")
