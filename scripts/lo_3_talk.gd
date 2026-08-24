extends Node2D
var is_here = false
@export var type = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("go_to") and is_here or Input.is_action_pressed("go_to") and is_here:
		match type:
			0:		get_parent().get_child(0).lo_2_talk_init()
			1:		get_parent().get_parent().get_child(0).lo_2_talk_passage_init()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		is_here = false
