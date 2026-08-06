extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var is_here = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true
			
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("go_to") && is_here or Input.is_action_just_pressed("go_to") && is_here:

		GameManager.player_spawn = 177
		GameManager.save(get_parent().get_node('Player').get_node('AB_Timer').time_left)
		GameManager.content_to_save['level'] = "res://scenes/levely/krčma_level.tscn"
		GameManager._save(177)
		get_parent().get_node('Player').restore_bindings()
		get_parent().get_node('Player').vytriezvi()
		GameManager.enter_level( "res://scenes/levely/krčma_level.tscn")
