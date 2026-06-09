
extends Area2D

	
func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		_transition(Color(1, 1, 1))


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		_transition(Color(0.05, 0.05, 0.05))


var _tween: Tween

@export var transition_duration: float = 2.0

func _transition(to_color: Color):
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_method(
		func(c): $"../CanvasModulate".color = c,
		$"../CanvasModulate".color,
		to_color,
		transition_duration
	)
