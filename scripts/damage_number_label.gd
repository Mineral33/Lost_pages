extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func display():
	for i in range(10):
		modulate.a = move_toward(modulate.a, 1.0, 0.1)
		await get_tree().create_timer(0.05).timeout
	
	await get_tree().create_timer(2).timeout
	
	for i in range(10):
		modulate.a = move_toward(modulate.a, 0.0, 0.1)
		await get_tree().create_timer(0.05).timeout
	queue_free()
