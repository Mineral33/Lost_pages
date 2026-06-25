extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.




var is_here = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("go_to") and is_here or Input.is_action_pressed("go_to") and is_here:
		#print('open')
		get_parent().get_child(0).kovac_init()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false


var is_here_damage = null
func _on_hot_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here_damage = true
		while is_here_damage:
			area.get_parent().take_damage(50,'m', 'hot')
			await get_tree().create_timer(0.5).timeout
func _on_hot_area_exited(area: Area2D) -> void:
		if area.get_parent() is Player:
			is_here_damage = false
		
