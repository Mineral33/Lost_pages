extends Node2D
@export var wiew_image = preload("res://assets/pozadie/predDrotaverínom.png")
var is_here = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	##print(self)
	##print(!opened_bool)
	if (Input.is_action_just_pressed("go_to")  or Input.is_action_pressed("go_to")) and is_here:
		get_parent().get_child(0).show_view(wiew_image)
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
#func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
##	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
	#		get_parent().get_child(0).show_view(wiew_image)
