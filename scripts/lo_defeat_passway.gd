extends Node2D


# Called when the node enters the scene tree for the first time.
var ground = preload("res://scenes/ingame_elements/decoration/collision/ice_ground/ice_ground5.tscn")
var spawn = false

func _ready() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame

	if GameManager.lo_defeat == true:
		for marker in get_children():
			var ground_inst = ground.instantiate()
			get_tree().current_scene.add_child(ground_inst)
			ground_inst.global_position = marker.global_position

		
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print('===========',GameManager.lo_defeat)
#	print(ground_inst.global_position)
	pass
