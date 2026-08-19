extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape2D.disabled = true
	$Sprite2D.hide()
	$AnimationPlayer.play('shine')
	await  get_tree().create_timer(1.5)
	$CollisionShape2D.disabled = false
	$Sprite2D.show()
	$Sprite2D2.hide()
	$Sprite2D3.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
