extends Node2D

var applied = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !applied:
		var player = area.get_parent()
		
		player.take_damage(player.health*0.8,'m','fell')
		applied = true
