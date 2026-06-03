extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var damage_number = preload("res://scenes/UI/damage_number_label.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func display_took_damage(amount):
	var x = randf_range(0, size.x)
	var y = randf_range(0, size.y)
	
	var number = damage_number.instantiate()
	number.text = str(amount)
	number.add_theme_color_override("font_color", Color('#ffffff'))
	get_parent().get_parent().add_child(number)
	number.global_position = global_position + Vector2(x,y)
	number.modulate.a = 0.0
	
	number.display()
func display_took_damage_player(amount):
	var x = randf_range(0, size.x)
	var y = randf_range(0, size.y)
	
	var number = damage_number.instantiate()
	number.text = str(amount)
	number.add_theme_color_override("font_color", Color('#733a2b'))
	get_parent().get_parent().add_child(number)
	number.global_position = global_position + Vector2(x,y)
	number.modulate.a = 0.0
	
	number.display()
func display_took_heal(amount):
	var x = randf_range(0, size.x)
	var y = randf_range(0, size.y)
	
	var number = damage_number.instantiate()
	number.text = str(amount)
	number.add_theme_color_override("font_color", Color('#00640d'))
	get_parent().get_parent().add_child(number)
	number.global_position = global_position + Vector2(x,y)
	number.modulate.a = 0.0
	
	number.display()
func display_took_heal_shield(amount):
	var x = randf_range(0, size.x)
	var y = randf_range(0, size.y)
	
	var number = damage_number.instantiate()
	number.text = str(amount)
	number.add_theme_color_override("font_color", Color('#1699ff'))
	get_parent().get_parent().add_child(number)
	number.global_position = global_position + Vector2(x,y)
	number.modulate.a = 0.0
	
	number.display()
