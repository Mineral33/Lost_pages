extends Node2D

var plr = null
@export var damage = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.hide()
	$AnimationPlayer.play("shine")
	$Area2D/CollisionPolygon2D.disabled = true
	await get_tree().create_timer(2).timeout
	$Sprite2D.show()
	$AnimationPlayer.stop()
	$Sprite2D2.hide()
	$Sprite2D3.hide()
	$Sprite2D4.hide()
	$Area2D/CollisionPolygon2D.disabled = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(area)
	if area.get_parent() is Player:
		#print('player in ')
		plr = area.get_parent()
		while plr is Player:
			area.get_parent().take_damage(damage, 'm', 'au')
			await get_tree().create_timer(1).timeout
			
			
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		#print('player out')
		plr = null


func _on_timer_timeout() -> void:
	$Area2D/CollisionPolygon2D.disabled = true
	for i in range(10):
		scale = scale.move_toward(Vector2(0.05,0.05), Vector2(0.035, 0.035).length())
		await get_tree().create_timer(0.1).timeout
		
	queue_free()
