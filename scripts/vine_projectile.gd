extends Area2D


var parent = null
var dir =Vector2.ZERO
var is_projectile = false


func _ready() -> void:
	parent = get_parent().get_node('vine_boss')
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().take_damage(10,'p','vines')
		parent.projectile_hit()
		#print('hit')
		queue_free()
func _process(delta: float) -> void:
	if is_projectile:
		position += dir * 7
	
