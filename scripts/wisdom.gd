extends Node2D

@export var type = 'folk'
var opened_bool=  false
var is_here = false
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready() -> void:
	$AnimationPlayer.play("idle")




func _input(event: InputEvent) -> void:
	#print(self)
	#print(!opened_bool)
	if (Input.is_action_just_pressed("go_to")  or Input.is_action_pressed("go_to")) and is_here and !opened_bool:
		print('wl activate:' ,!opened_bool)
		get_parent().get_child(0).wisdom_lockdown(type,randi_range(200,250))
		$AnimationPlayer.play("empty")
		get_parent().wisdom_found(self)
		GameManager.update_log_info('Lost page found')
		opened_bool = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
func opened():
	$AnimationPlayer.play("empty")
	opened_bool = true
