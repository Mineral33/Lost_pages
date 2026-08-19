extends Node2D
var triggered = false
@export var type = ''
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player and !triggered:
		match type:
			'lo1':
				get_parent().get_child(0).lo_cutscene()
			'lo2': 
				get_parent().get_child(0).lo_cutscene_2()
		
		triggered = true

#func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
##	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
	#		get_parent().get_child(0).show_view(wiew_image)
