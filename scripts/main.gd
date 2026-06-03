extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# hide coin and number of coins in main menu
	$UImanager.get_child(0).hide()
	$UImanager.get_child(1).hide()
	$UImanager.get_child(5).show()
	$UImanager.get_child(12).hide()
	$UImanager.get_child(9).hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
