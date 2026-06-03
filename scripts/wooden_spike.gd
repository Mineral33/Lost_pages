extends Node2D

var plr = null
@export var damage = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area)
	if area.get_parent() is Player:
		print('player in ')
		plr = area.get_parent()
		while plr is Player:
			area.get_parent().take_damage(damage, 'm', 'au')
			await get_tree().create_timer(1).timeout
			
			
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		print('player out')
		plr = null
