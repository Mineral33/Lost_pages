extends Node2D
@export var to_level_name= 'unknown'
@export var path_to_level = "res://scenes/levely/les.tscn"
@export var cutscene = 0

var mouse_in = false
var is_here = null
@export var player_spawn = 1
@export var texture_index  = 1 
var texture_alt
func _ready() -> void:
	if texture_index == 1:
		texture_alt = preload("res://assets/decoration/door/dvere.png")
	elif texture_index == 2:
		texture_alt = preload("res://assets/decoration/door/lesne_dvere.png")
	elif texture_index == 5:
		$Sign.hide()
		texture_alt = preload("res://assets/decoration/door/hidden_door.png")

	$Sprite2D.texture = texture_alt
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("go_to") && is_here or Input.is_action_just_pressed("go_to") && is_here:
			GameManager.player_spawn = player_spawn
			GameManager.save(get_parent().get_node('Player').get_node('AB_Timer').time_left)
			GameManager.content_to_save['level'] = path_to_level
			GameManager._save(player_spawn)
			get_parent().get_node('Player').restore_bindings()
			get_parent().get_node('Player').vytriezvi()
			if cutscene == 0:
				GameManager.enter_level(path_to_level)
			elif cutscene > 0:
				get_parent().get_child(0).level_transition_cutscene(path_to_level,0,0)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true
		
		
			
			
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
func _on_area_2d_mouse_entered() -> void:
	mouse_in = true
	$Sign/Label.text = to_level_name
	$Sign/Label.show()
func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
	$Sign/Label.hide()
