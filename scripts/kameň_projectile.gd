extends Area2D


var parent
var velocity
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	queue_free()
	
func _process(delta: float) -> void:
	position += velocity * delta
	
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		if is_instance_valid(parent):
			parent.teleport_hit()
			queue_free()
