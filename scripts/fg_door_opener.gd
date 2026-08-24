extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !GameManager.fg_defeat:
		$lo_3_talk.hide()
		$lo_3_talk.get_node('Area2D').get_node('CollisionShape2D').disabled = true
		$"../door_back2".get_node('Area2D').get_node('CollisionShape2D').disabled = true
		$"../door_back2".get_node('Sign').hide()
		
	else:
		$lo_3_talk.hide()
		$lo_3_talk.get_node('Area2D').get_node('CollisionShape2D').disabled = false
		$"../door_back2".get_node('Area2D').get_node('CollisionShape2D').disabled = false
		$"../door_back2".get_node('Sign').show()
		$lo_3_talk.show()
		$IceWallHole.z_index = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
