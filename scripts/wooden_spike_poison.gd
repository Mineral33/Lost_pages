extends Node2D
@export var poison_tick_damage =5 
@export var ticks  = 10
@export var tick_time =0.5
var plr = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		
		plr = area.get_parent()
		while plr is Player:
			
			area.get_parent().poison(poison_tick_damage ,tick_time, ticks, ' uff')
			await get_tree().create_timer(1).timeout
			
			
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		plr = null
