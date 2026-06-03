extends Node2D

var player
var spawn = GameManager.player_spawn
var spawn_position = Vector2(350,280)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().current_scene.get_child(0).get_child(5).hide()
	self.get_child(0).get_child(5).hide()
	if spawn == 0:
		spawn_position = $base_spawn.position
	elif spawn == 1:
		spawn_position = $tree_spawn.position
	elif spawn == 2:
		spawn_position = $"ladove dvere".position
	player = $Player
	
	if spawn_position:
		player.position = spawn_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
